# Planning Artifact — REMED-023

## Ticket
- **ID**: REMED-023
- **Title**: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract
- **Wave**: 29
- **Lane**: remediation
- **Stage**: planning
- **Finding source**: EXEC-BLENDER-001
- **Source ticket**: MODEL-007

---

## 1. Scope

Remediate EXEC-BLENDER-001 by proving the Blender-MCP bridge correctly chains saved-blend paths when the caller explicitly forwards them. Verify this with a fresh execution using current opencode.jsonc state.

**Affected surfaces:**
- `.blender-mcp/audit/audit_20260417.jsonl` (existing historical evidence)
- `opencode.jsonc` (blender_agent MCP configuration)

**Not in scope:**
- No changes to bridge source code
- No changes to opencode.jsonc configuration
- No new Blender-MCP tool development

---

## 2. Files or Systems Affected

| Surface | Role |
|---------|------|
| `opencode.jsonc` | blender_agent MCP configuration (must be enabled to execute fresh chain) |
| `.blender-mcp/audit/audit_20260417.jsonl` | Historical proof (lines 18-20, job_id `20260417T030247Z-761597ed6a`) |
| `tmp/` | Temporary blend file storage for chaining chain |

---

## 3. Implementation Steps

### Step 1: Verify blender_agent MCP is enabled

**Action:** Confirm `blender_agent.enabled: true` in `opencode.jsonc`.

**Expected state:** Enabled = true (per current read; was false at time of REMED-018 which is now resolved).

**If enabled:** Proceed to Step 2.
**If disabled:** Fall back to historical evidence approach (Step 3).

---

### Step 2: Execute fresh Blender-MCP chaining chain

Execute the proven 2-step chain from REMED-009:

**2a.** `project_initialize(output_blend="/home/rowan/womanvshorseVC/tmp/remed-023-test-init.blend")`

**2b.** From 2a response, extract `persistence.saved_blend`

**2c.** `scene_batch_edit(input_blend=<saved_blend>, output_blend="/home/rowan/womanvshorseVC/tmp/remed-023-test-chain.blend", operations=[...])`

**2d.** Inspect audit log for the scene_batch_edit `job_start` record — verify `input_blend` and `output_blend` are non-null.

---

### Step 3: Historical evidence fallback (if Step 2 cannot execute)

If blender_agent is disabled or tools are unavailable, use existing audit evidence:

**Evidence source:** `audit_20260417.jsonl` lines 18-20, job_id `20260417T030247Z-761597ed6a`

```
record_id: 20260417030247-3fbf8bdecb26
event_type: job_start
job_id: 20260417T030247Z-761597ed6a
tool_name: scene_batch_edit
input_blend: /home/rowan/womanvshorseVC/tmp/remed-009-test-init.blend   ← NON-NULL
output_blend: /home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend  ← NON-NULL
success: true
```

This record proves the bridge correctly forwards blend paths when caller provides them. This was the definitive proof used by REMED-009 and REMED-018.

---

### Step 4: Evidence recording

Record the following for both ACs:
- Exact audit log grep output showing `input_blend` and `output_blend` non-null
- Job ID, timestamp, and tool name
- PASS/FAIL verdict per AC

---

## 4. Acceptance Criteria

| AC | Description | Verification |
|----|-------------|--------------|
| AC-1 | EXEC-BLENDER-001 no longer reproduces | Audit log `job_start` record shows non-null `input_blend` and `output_blend` |
| AC-2 | Blender-MCP chaining chain proves correct blend forwarding | Fresh execution OR historical evidence (lines 18-20) confirms non-null blend paths on `job_start` |

---

## 5. Risks and Assumptions

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| blender_agent is disabled | **Low** | opencode.jsonc shows `enabled: true`; if wrong, fall back to historical evidence |
| Blender binary not accessible | **Low** | Bootstrap is ready; Blender path `/home/rowan/.local/bin/blender` confirmed in prior runs |
| Fresh chain fails to forward blend paths | **Low** | REMED-009 proved the pattern works; if fresh chain fails while historical succeeds, document discrepancy |

**Assumptions:**
- Blender 4.5.0 is available at `/home/rowan/.local/bin/blender`
- Audit logging is active (`BLENDER_MCP_ENABLE_AUDIT_LOGGING: "true"` in opencode.jsonc)
- `tmp/` directory is writable

---

## 6. Blockers

| Blocker | Resolution |
|---------|------------|
| None identified at planning stage | Proceed to plan review |

If blender_agent is found disabled during execution, document the finding and fall back to historical evidence.

---

## 7. AC Mapping

| AC | Evidence Required | Source |
|----|-------------------|--------|
| AC-1 | Audit log `job_start` with non-null `input_blend` and `output_blend` | Fresh execution (Step 2) or historical (audit_20260417.jsonl line 18) |
| AC-2 | Same audit log record proves blending chaining works | Same as AC-1 |

---

## 8. Precedent

- **REMED-009** (wave 15): Proved correct chaining with audit evidence — CLOSED DONE
- **REMED-018** (wave 24): Used same historical evidence when fresh attempt blocked by disabled MCP — CLOSED DONE
- **This ticket (REMED-023)**: Fresh attempt now possible since `enabled: true`; falls back to historical if needed

---

## 9. Zero Blockers Confirmation

All dependencies and prerequisites are satisfied:
- Bootstrap is ready (workflow-state `bootstrap.status: ready`)
- blender_agent is enabled in opencode.jsonc
- Historical audit evidence exists at `audit_20260417.jsonl` lines 18-20
- No code changes required
