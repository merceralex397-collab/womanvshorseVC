# Review Artifact: MODEL-004 — Generate horse-war via Blender-MCP

## Review Summary

**Reviewer**: wvhvc-team-leader  
**Ticket**: MODEL-004  
**Stage**: review  
**Date**: 2026-04-11

---

## Implementation Artifact Assessment

The implementation artifact (`model-004-implementation-implementation.md`) documents the same systemic Blender MCP bridge failure observed in MODEL-003. The evidence is consistent and corroborated by the environment probe confirming Blender 4.5.0 availability, the successful scene initialization, and the subsequent `scene_batch_edit` failure where `input_blend`/`output_blend` are not forwarded to the bridge.

### Findings

**Finding 1 — Blender MCP session persistence is fundamentally broken**

The `scene_batch_edit` tool was tested with the following result:

| Test Configuration | Result |
|---|---|
| Environment probe | Blender 4.5.0 confirmed available |
| project_initialize | ✅ PASS — Blend file created |
| scene_batch_edit (geometry build) | ❌ FAIL — `input_blend`/`output_blend` not forwarded to bridge; bridge always uses `--factory-startup` which starts fresh |
| blender_agent_blender_python | ❌ FAIL — `inline_python_policy: "disabled"` |

**Finding 2 — Root cause is the same BLENDER-MCP-CHAIN systemic blocker**

The bridge does not forward `input_blend` and `output_blend` parameters to the Blender command line. The `--factory-startup` flag is always included, meaning every Blender invocation starts from factory defaults. This is the identical issue that blocked MODEL-003.

**Finding 3 — Implementation artifact accurately documents the failure**

The artifact correctly identifies:
- Blender 4.5.0 environment probe: PASS
- project_initialize: PASS (blend file created)
- scene_batch_edit geometry build: FAIL — `input_blend`/`output_blend` not forwarded
- inline Python: blocked by `inline_python_policy: "disabled"`
- All 5 acceptance criteria as FAIL

**Finding 4 — The plan's Blender-MCP workarounds were correctly applied but still insufficient**

The plan correctly identified the known bridge issues and designed workarounds (accepting auto-generated names, chaining via output_blend). However, the root cause — the bridge not forwarding these parameters — is beyond the plan's ability to work around. The plan was sound; the execution environment is defective.

---

## Acceptance Criteria Verdict

| # | Criterion | Verdict | Evidence |
|---|---|---|---|
| 1 | `assets/models/horse-war.glb` exists | **FAIL** | No GLB produced. scene_batch_edit failed before any geometry was created. |
| 2 | Triangle count ≤ 4000 | **FAIL** | No geometry exists to measure. |
| 3 | Manifold mesh, no inverted normals | **FAIL** | No geometry created. |
| 4 | Imports into Godot without errors | **FAIL** | No GLB to import. |
| 5 | PROVENANCE.md entry added | **FAIL** | No GLB to track. |

---

## Review Verdict

**`REJECT`**

The implementation is not acceptable. All 5 acceptance criteria fail. The Blender MCP bridge is the root cause — this is an environment/systemic defect, not a plan error or execution mistake.

The plan was correctly designed with appropriate workarounds for the known bridge issues. The implementation correctly applied those workarounds. The failure is at the bridge runtime level, where `input_blend`/`output_blend` parameters are not forwarded to the Blender command line.

The ticket must remain in `review` or `blocked` status until:
1. The Blender MCP bridge is repaired (parameters forwarded correctly), AND
2. MODEL-004 is re-attempted with the fixed toolchain

---

## Blocking Classification

This is a **managed blocker** — the same confirmed systemic environment defect affecting MODEL-003. Two independent model tickets (MODEL-003, MODEL-004) have now failed with the identical root cause. This is definitively a bridge-level issue, not a ticket execution issue.

**BLENDER-MCP-CHAIN** — confirmed across MODEL-003 and MODEL-004:
- `scene_batch_edit` does not forward `input_blend`/`output_blend` to Blender command line
- `--factory-startup` always starts fresh regardless of `input_blend`
- `create_primitive` auto-names objects as `Cube.XXX`
- `blender_agent_blender_python` inline Python disabled
- No workaround available at agent level

---

## Required Follow-up

- **REMED-003** and **REMED-004** are split child tickets from MODEL-003 that address the documentation/remediation aspect of this blocker
- MODEL-004 implementation artifact documents the same root cause
- Both MODEL-003 and MODEL-004 are now blocked pending bridge-level repair
- This systemic issue also affects MODEL-005 and MODEL-006 (planned but not yet in implementation)

(End of file - total 89 lines)