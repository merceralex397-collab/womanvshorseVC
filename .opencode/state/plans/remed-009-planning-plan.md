# Planning Artifact — REMED-009

**Ticket**: REMED-009  
**Stage**: planning  
**Kind**: plan  
**Owner**: wvhvc-planner  
**Lane**: remediation  
**Wave**: 15  
**Source**: MODEL-003 (split_scope, sequential_dependent)

---

## 1. Scope

Prove that the Blender MCP bridge now correctly forwards `input_blend`/`output_blend` for stateful chaining, and that the finding EXEC-BLENDER-001 (recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract) no longer reproduces.

---

## 2. Finding Summary

**EXEC-BLENDER-001**: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

**Root Cause**: The Blender MCP bridge command always includes `--factory-startup`, which causes Blender to start from factory defaults, ignoring any `input_blend` argument. The bridge also fails to forward `input_blend` in the job JSON even when `--factory-startup` is absent — a secondary systemic defect confirmed in audit logs.

**Audit Evidence** (from `.blender-mcp/audit/audit_20260411.jsonl`):

| job_id | tool_name | `--factory-startup`? | input_blend in job_start |
|--------|-----------|----------------------|--------------------------|
| 20260411T161720Z-890ae164d1 | project_initialize | YES | **null** |
| 20260411T161733Z-3878341b68 | scene_batch_edit | YES | **null** |
| 20260411T161745Z-72ffa6e3e5 | scene_batch_edit | YES | **null** |
| 20260411T161806Z-08ca03018a | scene_query | YES | **null** |
| 20260411T161827Z-ce2cc8d0bd | scene_batch_edit | NO | **null** |
| 20260411T161857Z-87b1bec923 | scene_batch_edit | NO | **null** |
| 20260411T161923Z-05bf3b5bb6 | scene_batch_edit | YES | **null** |
| 20260411T162020Z-74ac61393d | project_initialize | NO | **null** |

**Key Observation**: Even `project_initialize` calls WITHOUT `--factory-startup` (job_id 20260411T162020Z) still record `input_blend: null` in the job_start record. The bridge is broken at the job-JSON construction layer — it does not write `input_blend` into the job JSON regardless of `--factory-startup`.

---

## 3. Approach: Prove Correct Chaining Chain

The acceptance criteria requires demonstrating a **correct chaining chain**:

1. Call `project_initialize(output_blend=...)` → receive `persistence.saved_blend` in the result
2. Call a mutating `scene_batch_edit` with `input_blend=<saved_blend>` from step 1
3. Verify `.blender-mcp/audit/*.jsonl` records **non-null `input_blend` and `output_blend`** on the matching `job_start` records for both calls

**If the bridge is repaired**, the chain would be:
- Step 1: `project_initialize(output_blend="/tmp/remed-009-test.blend")`
  - Expected: `job_start` record shows `input_blend: null`, `output_blend: /tmp/remed-009-test.blend`
  - Expected: `job_complete` record shows non-null `output_blend_hash`
- Step 2: `scene_batch_edit(input_blend="/tmp/remed-009-test.blend", output_blend="/tmp/remed-009-test2.blend", operations=[...])`
  - Expected: `job_start` record shows `input_blend: /tmp/remed-009-test.blend`, `output_blend: /tmp/remed-009-test2.blend`
- Step 3: Inspect audit log — both job_start records must show non-null `input_blend`/`output_blend`

---

## 4. Implementation Steps

> **BLOCKER**: The bridge defect (input_blend not forwarded in job JSON) must be fixed before Steps 2–3 can succeed. REMED-009 cannot close without a repaired bridge. This planning artifact documents the required approach once the bridge defect is resolved.

### Step 1 — Probe Current Bridge State (CONFIRM DEFECT EXISTS)

Run `blender_agent_environment_probe` to confirm the bridge version and `--factory-startup` posture.

### Step 2 — Probe Audit Log Baseline (CONFIRM NULL INPUT_BLEND)

Inspect the current audit log for the test job IDs to establish the pre-fix baseline (input_blend=null expected).

### Step 3 — Attempt Correct Chain (EXPECTED TO FAIL — CONFIRMS DEFECT)

**Sub-step 3a**: `blender_agent_project_initialize`
- `output_blend="/tmp/remed-009-chain.blend"`
- `project_root="/home/rowan/womanvshorseVC"`
- Expected result: `persistence.saved_blend` returned with a path
- Audit log check: `job_start` for this call shows `input_blend: null`, `output_blend: /tmp/remed-009-chain.blend`

**Sub-step 3b**: `blender_agent_scene_batch_edit`
- `input_blend="/tmp/remed-009-chain.blend"` (reuse from 3a)
- `output_blend="/tmp/remed-009-chain-stage2.blend"`
- `operations=[{"action": "create_primitive", "primitive": "cube", "object": "TestCube"}]`
- Audit log check: `job_start` for this call must show `input_blend: /tmp/remed-009-chain.blend` (THIS WILL FAIL — confirms defect)

### Step 4 — If Bridge Is Repaired During This Ticket

If the bridge is repaired (e.g., by the team or a parallel lane), re-run Steps 3a–3b and verify the audit log now shows non-null `input_blend`/`output_blend` on the matching `job_start` records.

### Step 5 — Closeout Evidence

Once the chain works, produce closeout evidence:
- Extract the two `job_start` records (one from `project_initialize`, one from `scene_batch_edit`)
- Show that both have non-null `input_blend` and `output_blend`
- This satisfies AC-1 (EXEC-BLENDER-001 no longer reproduces) and AC-2 (audit log shows correct chaining proof)

---

## 5. Verification Plan

1. **Pre-fix audit check**: Confirm the audit log for Steps 3a–3b shows `input_blend: null` on the mutating `scene_batch_edit` call (proves defect was live)
2. **Post-fix audit check**: Confirm the audit log shows non-null `input_blend` and `output_blend` on both `job_start` records
3. **Hash continuity**: Verify `output_blend_hash` of Step 3a matches `input_blend_hash` of Step 3b (proves same file is chained)
4. **No --factory-startup in post-fix call**: Verify the `command_executed` field of the mutating call does not include `--factory-startup`, OR if it does, confirm the job JSON still carries the correct `input_blend`

---

## 6. AC Mapping

| AC | Requirement | Pass Criterion |
|----|-------------|----------------|
| AC-1 | EXEC-BLENDER-001 no longer reproduces | A mutating Blender MCP call (scene_batch_edit with geometry-creating operation) receives a non-null `input_blend` in its job JSON and the audit log records it as non-null |
| AC-2 | Audit log shows non-null input_blend/output_blend on correct chain | Both `project_initialize` and the subsequent `scene_batch_edit` have `job_start` records with non-null `input_blend`/`output_blend`, and `input_blend_hash` of step 2 matches `output_blend_hash` of step 1 |

---

## 7. Risks and Assumptions

- **Risk**: The bridge defect (input_blend not forwarded) is systemic — it cannot be worked around from the agent side. The bridge must be repaired externally or by another lane.
- **Assumption**: The Blender MCP bridge at `/home/pc/projects/blender-agent/mcp-server/src/blender_mcp_server/bridge_runtime.py` can be updated to (a) remove `--factory-startup` and (b) correctly write `input_blend` into the job JSON.
- **Assumption**: Audit log writes are synchronous — the `job_start` record is written before the tool call returns.

---

## 8. Blockers and Required User Decisions

| Blocker | Description |
|---------|-------------|
| **BRIDGE-DEFECT** | The Blender MCP bridge does not forward `input_blend` in the job JSON (confirmed in audit logs). This makes it impossible to construct a correct chaining chain. The bridge code (`bridge_runtime.py`) must be repaired to write `input_blend` and `output_blend` into the job JSON and to stop injecting `--factory-startup` when an `input_blend` is provided. **REMED-009 cannot close until the bridge is fixed.** |
| **ACcepance Criteria Gap** | The acceptance criteria demands a "prove one correct chain" demonstration, but the defect prevents constructing that chain. If the bridge cannot be repaired, the AC must be reframed as "no new null-input_blend mutating calls are recorded in the audit log after date X" rather than "correct chain demonstrated." |
