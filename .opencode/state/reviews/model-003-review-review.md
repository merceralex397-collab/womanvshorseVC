# Review Artifact: MODEL-003 — Generate horse-black via Blender-MCP

## Review Summary

**Reviewer**: wvhvc-team-leader  
**Ticket**: MODEL-003  
**Stage**: review  
**Date**: 2026-04-11

---

## Implementation Artifact Assessment

The implementation artifact (`model-003-implementation-implementation.md`) documents a systematic Blender MCP bridge failure. The evidence presented is consistent with and corroborated by the bridge's declared `scene_persistence_rule: "stateless"` and the observed `input_loaded: false` across all `scene_batch_edit` results.

### Findings

**Finding 1 — Blender MCP session persistence is fundamentally broken**

The `scene_batch_edit` bridge tool was tested across 20+ invocations in the following configurations:

| Test Configuration | Result |
|---|---|
| Multi-operation batch within single call (create_primitive + set_transform) | `BridgeError: Object 'X' was not found` — create_primitive creates `Cube.XXX` (auto-name), set_transform cannot find user-specified name |
| Single operation, no output_blend set | `ok: true` but `saved_blend: null` — scene not persisted |
| project_initialize → scene_batch_edit (same blend file) | `input_loaded: false` — bridge always starts `--factory-startup` regardless of input_blend |
| Inline Python | `inline_python_policy: "disabled"` — not available as workaround |

**Finding 2 — Root cause is confirmed**

The bridge command always includes `--factory-startup`:
```
blender --factory-startup --background --python <bridge> -- --job <job.json>
```
This causes `input_loaded: false` in every result. The Blender process always starts from factory defaults. `create_primitive` auto-names objects as `Cube.XXX`, ignoring the `object` parameter. Subsequent `set_transform` operations cannot find user-specified names.

**Finding 3 — Implementation artifact accurately documents the failure**

The artifact correctly identifies:
- The specific `BridgeError` messages from each failure mode
- The `scene_persistence_rule: "stateless"` contract and its interaction with `--factory-startup`
- The `inline_python_policy: "disabled"` policy
- All 5 acceptance criteria as FAIL

**Finding 4 — No alternative Blender workflow was available**

The following workarounds were ruled out:
1. Multi-step single-call batching — same name-mismatch failure
2. Loading existing blend as `input_blend` — `--factory-startup` always starts fresh
3. `blender_agent_blender_python` — inline Python disabled
4. Session-based tools — no such tools available in the current MCP toolset

---

## Acceptance Criteria Verdict

| # | Criterion | Verdict | Evidence |
|---|---|---|---|
| 1 | `assets/models/horse-black.glb` exists | **FAIL** | No GLB produced. Implementation artifact confirms zero geometry was created. |
| 2 | Triangle count ≤ 2000 | **FAIL** | No geometry exists to measure. |
| 3 | Manifold mesh, no inverted normals | **FAIL** | No geometry created. |
| 4 | Imports into Godot without errors | **FAIL** | No GLB to import. |
| 5 | PROVENANCE.md entry added | **FAIL** | No GLB to track. |

---

## Review Verdict

**`REJECT`**

The implementation is not acceptable. All 5 acceptance criteria fail. The Blender MCP bridge is the root cause — this is an environment/systemic defect, not a plan error or execution mistake.

The ticket must remain in `review` or `blocked` status until:
1. The Blender MCP bridge is repaired (session-persistence fix), AND
2. MODEL-003 is re-attempted with the fixed toolchain

---

## Required Follow-up

- **REMED-003** was created as a split child ticket (sequential_dependent) from MODEL-003 to track the Blender MCP repair
- MODEL-003 is the parent and must complete before REMED-003 can be foregrounded
- **ANDROID-001** is independently blocked by bash permission denials (separate issue)

---

## Blocking Classification

This is a **managed blocker** — a confirmed systemic environment defect, not a ticket execution issue. The workflow correctly routes this as `blocked` rather than allowing self-remediation.

**BLENDER-MCP-CHAIN** — confirmed at `bridge_runtime.py` level:
- `create_primitive` does not respect `object` parameter
- `--factory-startup` always starts fresh regardless of `input_blend`
- `output_blend=null` never persists state
- No session-based alternative tool available
