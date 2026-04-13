# Planning Artifact — REMED-003

## Ticket
- **ID**: REMED-003
- **Title**: Remediation review artifact does not contain runnable command evidence
- **Stage**: planning
- **Finding Source**: EXEC-REMED-001
- **Source Ticket**: MODEL-004
- **Source Mode**: split_scope
- **Split Kind**: parallel_independent

---

## 1. Scope

Supersede REMED-003 as a stale remediation ticket. The finding EXEC-REMED-001 no longer reproduces because REMED-001's review artifact was regenerated with direct command evidence. No additional work is required; the remediation is already complete.

---

## 2. Files / Systems Affected

- `tickets/manifest.json` — REMED-003 status will be closed as superseded
- No product code, models, or runtime surfaces affected

---

## 3. Evidence That Finding Is Resolved

### Current REMED-001 Review Artifact

**Path**: `.opencode/state/reviews/remed-001-review-review.md` (lines 117-126)

Contains all three required evidence elements per REMED-003's fix approach:

| Required Element | Present in Artifact |
|---|---|
| Exact command run | ✅ `godot --headless --path /home/pc/projects/womanvshorseVC --quit` |
| Raw command output | ✅ STDOUT: "Error: Can't run project: no main scene defined in the project." / STDERR: '' / EXIT_CODE: 1 |
| Explicit PASS/FAIL result | ✅ "PASS — binary executes, engine starts, project.godot parses. Error is expected project state." |

### REMED-001 Ticket State

- `resolution_state: done`
- `verification_state: reverified`
- No open defect reproductions

### Related Tickets

- **REMED-002**: `resolution_state: done`, `verification_state: reverified` — same finding source (EXEC-REMED-001), also resolved
- **REMED-005**: `resolution_state: superseded` — created as parallel remediation, already superseded via `ticket_reconcile` with evidence from REMED-002

---

## 4. Implementation Steps

1. **Confirm authoritative source**: `.opencode/state/reviews/remed-001-review-review.md` is the canonical proof that EXEC-REMED-001 no longer reproduces.

2. **Run `ticket_reconcile`** with:
   - `source_ticket_id: "REMED-001"` — authoritative owner of the resolved finding
   - `target_ticket_id: "REMED-003"` — stale remediation ticket to supersede
   - `replacement_source_ticket_id: "REMED-001"` — evidence source
   - `evidence_artifact_path: ".opencode/state/reviews/remed-001-review-review.md"` — proof that finding is resolved
   - `reason: "EXEC-REMED-001 no longer reproduces. REMED-001 review artifact regenerated with direct command evidence (exact command, raw output, explicit PASS). REMED-001 is done and reverified. REMED-003 is stale."`
   - `supersede_target: true` — REMED-003 should close as superseded, not remain open

3. **Verify reconciliation result**: REMED-003 transitions to `resolution_state: superseded` and is removed from the active queue.

---

## 5. Validation Plan

After `ticket_reconcile` completes:
- REMED-003 status: `superseded`, not `open` or `todo`
- No remaining stale remediation tickets for EXEC-REMED-001
- No new work generated — finding already closed by prior remediation

---

## 6. Risks and Assumptions

- **Risk**: None identified. The finding is confirmed stale by the authoritative review artifact.
- **Assumption**: `ticket_reconcile` with `supersede_target: true` will close REMED-003 as superseded, consistent with the treatment of REMED-005.

---

## 7. Blockers

None. All required evidence exists in the current REMED-001 review artifact.

---

## 8. Acceptance Criteria Mapping

| REMED-003 Acceptance Criterion | Status |
|---|---|
| EXEC-REMED-001 no longer reproduces | ✅ RESOLVED — REMED-001 review contains command evidence |
| Quality checks rerun with fix evidence | ✅ N/A — finding is stale; no defect to re-check |

---

## Recommended Next Action

**Run `ticket_reconcile` to supersede REMED-003:**

```
ticket_reconcile(
  source_ticket_id="REMED-001",
  target_ticket_id="REMED-003",
  replacement_source_ticket_id="REMED-001",
  evidence_artifact_path=".opencode/state/reviews/remed-001-review-review.md",
  reason="EXEC-REMED-001 no longer reproduces. REMED-001 review artifact regenerated with direct command evidence (exact command, raw output, explicit PASS). REMED-001 is done and reverified. REMED-003 is stale.",
  supersede_target=true
)
```

REMED-003 will transition to `resolution_state: superseded` and the stale remediation lane will be cleared.