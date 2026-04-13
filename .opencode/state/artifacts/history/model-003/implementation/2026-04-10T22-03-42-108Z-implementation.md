# Implementation Artifact: MODEL-003 — Generate horse-black via Blender-MCP

## Summary

MODEL-003 implementation is **blocked**. The Blender MCP stateless bridge cannot support the multi-step geometry construction required to build the horse-black model. The `scene_batch_edit` tool has a fundamental session-persistence defect that prevents chaining create-operations with transform-operations across calls. Evidence gathered across 20+ tool invocations confirms the blocker is a bridge-level issue, not a parameter or workflow error.

---

## Blender MCP Chain Blocker Evidence

### Confirmed Behavior (20+ calls documented)

| Call Pattern | Result |
|---|---|
| `scene_batch_edit`: multi-op batch with `create_primitive` + `set_transform` | `set_transform` fails: "Object 'X' was not found" |
| `scene_batch_edit`: single `create_primitive`, no `output_blend` | `saved_blend: null` — scene not persisted |
| `project_initialize` → `scene_batch_edit` (same file, no `output_blend`) | Same: `saved_blend: null` |
| `scene_batch_edit`: `input_blend` set to existing file | `input_loaded: false` — bridge ALWAYS starts `--factory-startup` |

### Root Cause

The `scene_persistence_rule` states: *"Each mutating tool call runs in a separate background Blender process. Persist scene state by writing output_blend and passing that file as input_blend to the next call."*

However, the `scene_batch_edit` bridge command always includes `--factory-startup`:
```
blender --factory-startup --background --python <bridge> -- --job <job.json>
```

This causes `input_loaded: false` in every result regardless of the `input_blend` parameter. The Blender process always starts from the factory default scene, discarding any prior state. Additionally, `scene_batch_edit` returns `saved_blend: null` when `output_blend` is not set, making it impossible to persist intermediate state.

The combination means:
1. Each `scene_batch_edit` call starts fresh with an empty factory scene
2. `create_primitive` creates `Cube.XXX` (auto-generated name, ignoring the `object` parameter)
3. The created object is not persisted
4. A subsequent call with `set_transform` referencing that object fails

### Alternative Approaches Ruled Out

- **Inline Python**: `blender_agent_blender_python` — disabled by policy (`inline_python_policy: "disabled"`)
- **Loading existing blend as `input_blend`**: `input_loaded: false` confirmed — bridge ignores `input_blend` due to `--factory-startup`
- **Multi-operation single call**: First operation creates object with auto-name; subsequent `set_transform` fails to find user-specified name
- **Batch with all creates then all transforms**: Same failure mode — bridge resolves operations sequentially within one Blender invocation but object name mismatch persists

---

## Execution Log (Failed Attempts)

### Step 0 — Environment Probe
- **Tool**: `blender_agent_environment_probe`
- **Result**: PASS — Blender 4.5.0 at `/home/pc/blender-4.5.0/blender` accessible
- **Key finding**: `scene_persistence_rule: "stateless"`, `inline_python_policy: "disabled"`

### Step 1 — Project Initialize (Horse-Black Blend)
- **Tool**: `blender_agent_project_initialize`
- **Output**: `assets/models/horse-black.blend` and `tmp/horse-black.blend`
- **Result**: PASS — empty scene saved to blend file
- **Evidence**: `saved_blend: "/path/to/horse-black.blend"`, `output_blend_exists: true`

### Step 2 — Geometry Construction (20+ attempts)

All `scene_batch_edit` calls for geometry construction failed with the same root cause:

**Attempt pattern A (multi-op single call)**:
- Operations: `create_primitive` (name: BodyBarrel) + `set_transform` (object: BodyBarrel)
- Result: `BridgeError: Object 'BodyBarrel' was not found`
- Cause: Bridge resolves `set_transform` after `create_primitive` dispatches, but `create_primitive` uses auto-generated name `Cube.001`

**Attempt pattern B (single-op, no output_blend)**:
- Operations: `create_primitive` only
- Result: `ok: true`, `applied: ["Cube.001"]`, but `saved_blend: null`
- Cause: Without `output_blend` in the call, scene is not persisted

**Attempt pattern C (project_initialize → scene_batch_edit chain)**:
- First call: `project_initialize` — blend file saved with empty scene
- Second call: `scene_batch_edit` with same `output_blend` path
- Result: `saved_blend: null`, `input_loaded: false`
- Cause: Bridge's `--factory-startup` flag ignores the saved blend file

---

## Decision Blockers

| Blocker | Type | Evidence |
|---|---|---|
| `scene_batch_edit` ignores `object` parameter on `create_primitive` | Bridge bug | All calls show `Cube.XXX` auto-generated names regardless of `object` value |
| `--factory-startup` always starts fresh scene | Bridge configuration | `input_loaded: false` in all `scene_batch_edit` results |
| `output_blend=null` never persists | Bridge behavior | `saved_blend: null` in all single-op calls without `output_blend` |
| `scene_batch_edit` cannot chain across calls | Fundamental design | `stateless` model + `--factory-startup` + `output_blend=null` = no persistence possible |
| Inline Python disabled | Policy | `inline_python_policy: "disabled"` |

---

## Remediation Requirements

The Blender MCP server bridge needs repair before MODEL-003 can proceed:

1. **Fix A**: Remove `--factory-startup` from the `scene_batch_edit` bridge command when `input_blend` is provided, OR add a flag to disable factory startup
2. **Fix B**: Make `create_primitive` respect the user-specified `object` name parameter instead of auto-generating `Cube.XXX`
3. **Fix C**: Allow `output_blend` to be set in `scene_batch_edit` and actually persist the scene state to that file

**Alternative workaround**: If the blender-agent MCP server can be invoked without `--factory-startup` (e.g., via a session-based tool that doesn't start fresh), that would enable multi-step construction within a single Blender session.

---

## Acceptance Criteria Status

| Criterion | Status | Evidence |
|---|---|---|
| `assets/models/horse-black.glb` exists | ❌ FAIL | Not created |
| Triangle count ≤ 2000 | ❌ FAIL | No geometry created |
| Manifold mesh, no inverted normals | ❌ FAIL | No geometry created |
| Imports into Godot without errors | ❌ FAIL | No GLB produced |
| PROVENANCE.md entry added | ❌ FAIL | No GLB to track |

---

## Next Steps

1. **Remediation ticket needed** to repair the Blender MCP bridge for session/persistence support
2. **MODEL-003** remains in `implementation` stage with `blocked` status until bridge is repaired
3. **ANDROID-001** also blocked by bash permission denials — separate remediation ticket needed
4. Other Wave 1 model tickets (MODEL-004, MODEL-005, MODEL-006) are equally blocked by the same Blender MCP issue
