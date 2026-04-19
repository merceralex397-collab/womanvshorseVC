# Review Artifact: MODEL-007 — Generate sword-projectile via Blender-MCP

## Verdict: APPROVE

## Classification: **Managed External Blocker** — No Implementation Error

---

## 1. Blocker Verification

### 1a. Audit Log Evidence (Live, 2026-04-18)

The `audit_20260418.jsonl` confirms the exact failure pattern documented in the implementation artifact:

**Step 1 — project_initialize (PASS):**
```
Line 1: job_start  → input_blend: null, output_blend: "/home/rowan/...sword-projectile-stage0.blend"
Line 2: job_complete → output_blend_hash: "6aaed135..." ✓
Line 3: file_created → sword-projectile-stage0.blend ✓
```

**Steps 2–5 — scene_batch_edit (ALL FAIL with null blend paths):**
```
Line 4:  job_start  → input_blend: null, output_blend: null  [scene_batch_edit job_004713]
Line 5:  job_failure → warnings: "No output_blend was provided...No input_blend was provided..."
Line 6:  job_start  → input_blend: null, output_blend: null  [scene_batch_edit job_004722]
Line 7:  job_complete → warnings: "No output_blend was provided...No input_blend was provided..."
Line 8:  job_start  → input_blend: null, output_blend: null  [scene_batch_edit job_004733]
...repeated across all subsequent scene_batch_edit calls through line 17
```

All 6 scene_batch_edit job_start records show: `input_blend: null, output_blend: null`.  
All job_complete records carry the same pair of warnings confirming null blend forwarding failure.

### 1b. Root Cause Confirmed

The implementation artifact's root cause analysis is correct: the blend paths explicitly passed to `scene_batch_edit` (`input_blend: /home/rowan/womanvshorseVC/assets/models/sword-projectile-stage0.blend`, `output_blend: ...stage1.blend`) are NOT appearing in the Blender command line. The `--background /path/to/input.blend` argument is absent from all `command_executed` arrays.

This is **not** a blender_agent enable/disable issue — `enabled: true` is confirmed at `opencode.jsonc` line 29 (per REMED-023 review). The server processes requests but does not forward blend paths to the Blender invocation.

### 1c. Plan Conformance

The implementation correctly followed the plan (2026-04-17T16-05-00-591Z-plan.md):
- ✅ Step 1: project_initialize with correct output_blend path → PASS (stage0.blend created)
- ✅ Step 2: scene_batch_edit with explicit input_blend/output_blend chaining → FAIL (null paths, server bug)
- ✅ Step 3–5: Subsequent mesh_edit_batch/material_pbr_build calls → FAIL (same root cause)
- ✅ No implementation errors — calls correctly used the MODEL-003/MODEL-004 proven pattern

**No deviation from plan.** Implementation correctly followed the 7-step Blender-MCP chain with explicit blend forwarding.

---

## 2. Acceptance Criteria Results

| AC | Criterion | Result | Evidence |
|----|-----------|--------|----------|
| AC-1 | `assets/models/sword-projectile.glb` exists | **FAIL** | File not created — scene_batch_edit null blend paths |
| AC-2 | Triangle count ≤ 200 | **FAIL** | Model not generated |
| AC-3 | Manifold mesh, no inverted normals | **FAIL** | Model not generated |
| AC-4 | Imports into Godot without errors | **FAIL** | No GLB to import |
| AC-5 | PROVENANCE.md entry added | **FAIL** | No model to provenance |

**5/5 FAIL — All due to managed external blocker (blender_agent blend-path forwarding bug), not implementation error.**

---

## 3. Findings

### 3a. Blocking Defect
**None at implementation level.** The implementation correctly diagnosed and documented the server bug. All calls used the correct explicit `input_blend`/`output_blend` forwarding pattern proven by MODEL-003.

### 3b. Managed External Blocker (Server-Level Bug)

**Confirmed bug**: `blender_agent` MCP server does not forward `input_blend`/`output_blend` to the Blender `--background` command line for `scene_batch_edit` (and related v1 compat tools). This is a **server-level defect**, not a MODEL-007 implementation error.

**Evidence**: All 6 scene_batch_edit job_start records in `audit_20260418.jsonl` show null blend paths despite explicit parameter passing in the tool call. Command arrays confirm no `--background /path/to/input.blend` argument is present.

**Precedent**: MODEL-003 succeeded on 2026-04-17. MODEL-007 fails on 2026-04-18 with the same pattern. This suggests either a regression in the blender_agent server or an environment change that broke blend forwarding between those dates.

**Affected tools**: `scene_batch_edit`, `modifier_stack_edit`, `uv_workflow`, `material_pbr_build`, `export_asset`, `blender_python` — all v1 compat wrappers that should forward blend params.

---

## 4. Regression Risk

**Low** — The bug is in the MCP server infrastructure, not in the MODEL-007 implementation. No code changes were made to product surfaces. All previous successful tickets (MODEL-003, MODEL-004, MODEL-005, etc.) completed before this bug appeared.

---

## 5. Validation Gaps

**None at implementation level.** The audit log provides definitive, runnable evidence of the failure. The blocker is confirmed at the server level.

---

## 6. Next Action Recommendation

This ticket cannot close — all 5 ACs FAIL due to a server-level blender_agent bug. The follow-up ticket REMED-023 (source_follow_up from managed repair) addressed the blender_agent enablement but did not fix the blend-forwarding bug itself.

**Recommended disposition**: A new managed-blocker remediation ticket is required to:
1. Investigate and fix the `_wrap_v1_*` blend forwarding in the blender_agent MCP server, OR
2. Provide an alternative generation path (direct Blender invocation, pre-existing GLB asset, or v2 native API bypassing the v1 compat layer)

**MODEL-007 remains open** as the active foreground ticket awaiting resolution of the managed external blocker.

---

## 7. Historical Context

| Ticket | Outcome | Root Cause |
|--------|----------|------------|
| MODEL-003 (2026-04-17) | SUCCESS — 14-call chained workflow | Correct blend forwarding |
| REMED-023 (2026-04-18) | APPROVE — bridge is functional | Historical evidence of working blend forwarding |
| MODEL-007 (2026-04-18) | BLOCKED — same pattern fails | Server regression or env change |

The blender_agent server worked correctly on 2026-04-17 but fails on 2026-04-18. This is a regression that requires server-level investigation.

---

*Review artifact created: 2026-04-18T01:03:00Z*
*Verdict: APPROVE — Implementation correctly identified and documented the managed external blocker. No implementation error. All 5 ACs FAIL due to confirmed server-level blender_agent bug. Follow-up remediation required before MODEL-007 can close.*
