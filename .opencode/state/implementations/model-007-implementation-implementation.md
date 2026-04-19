# Implementation Artifact: MODEL-007 — Generate sword-projectile via Blender-MCP

## Status: BLOCKED

**Blocker**: Confirmed bug in blender_agent MCP server v1 compatibility layer — `input_blend` and `output_blend` parameters are NOT forwarded to `BlenderJobSpec` for `scene_batch_edit` and related tools. All calls result in `input_blend: null, output_blend: null` in the audit log despite explicit parameter passing.

## Asset Brief
- File: `assets/briefs/sword-projectile.md`
- Triangle budget: 200 tris (hard cap)
- Steel blade, 0.9m scale, symmetrical for spin readability
- Single steel material (#C0C0C0, roughness 0.4, metallic 0.9)

## Blender-MCP Tool Call Attempts

### Step 1: project_initialize — ✅ PASS
```
Tool: project_initialize
output_blend: /home/rowan/womanvshorseVC/assets/models/sword-projectile-stage0.blend
Result: saved_blend returned, file exists (372134 bytes)
```

### Step 2-5: scene_batch_edit — ❌ FAIL (bridge bug)
```
Tool: scene_batch_edit
input_blend: /home/rowan/womanvshorseVC/assets/models/sword-projectile-stage0.blend (EXPLICITLY PASSED)
output_blend: /home/rowan/womanvshorseVC/assets/models/sword-projectile-stage1.blend (EXPLICITLY PASSED)
Result: 
  - persistence.input_blend: null
  - persistence.output_blend: null
  - persistence.saved_blend: null
  - persistence.persisted_for_next_call: false
  - Warning: "No output_blend was provided. Scene changes are in-memory only"
  - Warning: "No input_blend was provided. This job starts from a fresh Blender scene"
```

**Root cause**: In `server_v2.py`, the v1 compatibility wrapper `_wrap_v1_scene_batch_edit` (line 1821-1830) receives `input_blend` and `output_blend` parameters but IGNORES them entirely:

```python
def _wrap_v1_scene_batch_edit(
    self,
    project_root: str,
    operations: list[dict[str, Any]],
    input_blend: str | None = None,  # RECEIVED BUT IGNORED
    output_blend: str | None = None,   # RECEIVED BUT IGNORED
) -> dict[str, Any]:
    v2_result = self.scene_edit(session_id="compat-session", operations=operations)
    # NOTE: input_blend and output_blend are NOT forwarded to scene_edit!
    return self.mapper.map_v2_to_v1_response("scene_batch_edit", v2_result)
```

The same bug affects: `modifier_stack_edit`, `uv_workflow`, `material_pbr_build`, `export_asset`, `blender_python`.

## Evidence

### Audit Log Entry (job_start event)
```json
{
  "event_type": "job_start",
  "tool_name": "scene_batch_edit",
  "input_blend": null,
  "output_blend": null,
  "command_executed": [
    "/home/rowan/.local/bin/blender",
    "--factory-startup",
    "--background",
    "--python",
    "/home/rowan/blender-agent/mcp-server/src/blender_mcp_server/bridge_runtime.py",
    "--",
    "--job", "...job.json",
    "--result", "...result.json"
  ]
}
```
Note: No input_blend path appears as positional argument after `--background`, confirming the path was not forwarded.

### Bridge Runtime Command Construction (from runner.py)
```python
# Line 195-199 in runner.py
command.append("--background")
project_root, input_blend, _ = self._resolve_paths(spec)
# input_blend is None because spec.input_blend was not forwarded
if input_blend is not None:
    command.append(str(input_blend))  # NEVER EXECUTED
```

## Acceptance Criteria Results

| AC | Criterion | Result |
|----|-----------|--------|
| AC-1 | `assets/models/sword-projectile.glb` exists | **FAIL** — GLB not generated |
| AC-2 | Triangle count ≤ 200 | **FAIL** — model not generated |
| AC-3 | Manifold mesh, no inverted normals | **FAIL** — model not generated |
| AC-4 | Imports into Godot without errors | **FAIL** — GLB not exported |
| AC-5 | PROVENANCE.md entry added | **FAIL** — no model to provenance |

## Comparison with Previously Successful Tickets

MODEL-003 (horse-black) succeeded with 14-call chained workflow. MODEL-007 fails at step 2 because the blender_agent server has a regression or the environment changed.

Key difference: MODEL-003 was executed on 2026-04-17 (audit_20260417.jsonl), MODEL-007 attempted on 2026-04-18 fails with same approach.

## Next Steps

This is a **server-level bug** that cannot be resolved through workflow changes. Options:

1. **Fix the blender_agent MCP server** — The `_wrap_v1_*` functions in `server_v2.py` must forward `input_blend` and `output_blend` to the v2 calls
2. **Use v2 API directly** — If v2 native tools don't have this parameter passing issue
3. **Direct Blender invocation** — Invoke blender directly via bash (blocked by permission system)
4. **Alternative generation** — Source a pre-made sword-projectile GLB from another path

---
*Implementation artifact updated: 2026-04-18T00:55:00Z*
*BLOCKER: blender_agent MCP server v1 compat bug — blend paths not forwarded*
