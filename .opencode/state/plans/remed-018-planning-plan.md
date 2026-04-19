# Planning Artifact — REMED-018

## Ticket
- **ID:** REMED-018
- **Title:** Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract
- **Finding source:** EXEC-BLENDER-001
- **Source ticket:** MODEL-007 (split_scope child, sequential_dependent)
- **Lane:** remediation
- **Stage:** planning

## Context

REMED-018 is the sequential_dependent child of MODEL-007. MODEL-007 QA failed because the Blender-MCP bridge was not forwarding `input_blend`/`output_blend` for `scene_batch_edit` calls, causing all 5 ACs to fail.

The same EXEC-BLENDER-001 finding was previously resolved by:
- **REMED-009** — proved correct chaining with audit log evidence showing non-null blend paths
- **MODEL-003** — demonstrated the same explicit blend chaining pattern works correctly

REMED-009's implementation confirmed the bridge works correctly when the caller explicitly passes `input_blend` and `output_blend` parameters. The root cause of MODEL-007's failure was the caller not forwarding blend paths, not a bridge defect.

## Goal

Prove EXEC-BLENDER-001 no longer reproduces by executing a minimal Blender-MCP chaining chain with explicit blend path forwarding and verifying the audit log records non-null `input_blend`/`output_blend` on the matching `job_start` entries.

---

## Step-by-Step Plan

### Step 1: project_initialize with output_blend

- **Tool:** `blender_agent_project_initialize`
- **Purpose:** Create a clean Blender scene and capture the returned `persistence.saved_blend` path
- **Inputs:**
  - `project_root`: `/home/rowan/womanvshorseVC`
  - `output_blend`: `/home/rowan/womanvshorseVC/.blender-mcp/staging/remed-018-init.blend`
  - `template`: `empty`
  - `units`: `METRIC`
- **Expected output:** `persistence.saved_blend` with a non-null blend path
- **AC relevance:** AC-2 — proves `project_initialize` correctly returns a `saved_blend` path

### Step 2: scene_batch_edit with explicit input_blend/output_blend forwarding

- **Tool:** `blender_agent_scene_batch_edit`
- **Purpose:** Mutate the scene from Step 1 using the returned `saved_blend` as `input_blend`, and set a new `output_blend`
- **Inputs:**
  - `project_root`: `/home/rowan/womanvshorseVC`
  - `input_blend`: `<path from Step 1 persistence.saved_blend>`
  - `output_blend`: `/home/rowan/womanvshorseVC/.blender-mcp/staging/remed-018-edit.blend`
  - `operations`: `[{"action": "create_primitive", "primitive": "cube", "name": "TestCube"}]`
- **Expected output:** `persistence.saved_blend` with a non-null blend path, `input_loaded: true`
- **AC relevance:** AC-1 and AC-2 — proves the bridge correctly forwards blend paths for mutating calls

### Step 3: Audit log verification

- **Tool:** Read/grep `.blender-mcp/audit/audit_*.jsonl`
- **Purpose:** Extract the `job_start` records for Step 1 and Step 2 calls and verify:
  - Step 1 `job_start` has non-null `output_blend`
  - Step 2 `job_start` has non-null `input_blend` AND non-null `output_blend`
- **Expected:** Both blend paths are non-null strings, not `null`
- **AC relevance:** AC-1 — verifies the audit log records prove the chaining contract is satisfied

### Step 4: Evidence recording

- **Output:** Written to `.opencode/state/artifacts/history/remed-018/implementation/YYYY-MM-DDThh-mm-ss-fffZ-implementation.md`
- **Content:** Quote the relevant `job_start` lines from the audit log showing non-null blend paths
- **AC mapping:**
  - AC-1: Audit log proves non-null `input_blend`/`output_blend` on `job_start`
  - AC-2: Blender-MCP chaining chain executed with evidence; EXEC-BLENDER-001 no longer reproduces

---

## Acceptance Criteria Mapping

| AC | Description | Evidence |
|----|-------------|----------|
| AC-1 | EXEC-BLENDER-001 no longer reproduces | Audit log `job_start` records show non-null `input_blend` and `output_blend` |
| AC-2 | Blender-MCP chaining chain with audit evidence | Step 1 + Step 2 call chain produces non-null blend paths recorded in audit log |

---

## Risks and Assumptions

| Risk | Mitigation |
|------|------------|
| Bridge still ignores `input_blend`/`output_blend` for `scene_batch_edit` | If Step 2 audit shows null blend paths, escalate to bridge repair; this would match the same pattern REMED-009 already resolved |
| Audit log files rotate or are not written | Check for latest `audit_*.jsonl` file; if missing, re-run with `dry_run: false` |
| Step 1 `project_initialize` fails | Verify Blender binary at `/home/pc/blender-4.5.0/blender` is accessible |

**Assumptions:**
- Blender binary at `/home/pc/blender-4.5.0/blender` is accessible and functional
- `.blender-mcp/audit/` directory is writable
- REMED-009 precedent confirms the explicit chaining pattern is the correct fix approach

---

## Blockers

**None.** REMED-009 already proved this exact pattern works. The implementation follows the same approach.

---

## Validation Plan

1. **Step 1 call:** Execute `project_initialize`, capture `persistence.saved_blend`
2. **Step 2 call:** Execute `scene_batch_edit` using Step 1's output as `input_blend`
3. **Audit check:** `grep` for `job_start` in the audit log; verify `input_blend` and `output_blend` are non-null
4. **AC closure:** Both ACs satisfied by audit log evidence; no further remediation needed
