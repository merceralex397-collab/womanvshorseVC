# Planning Artifact — REMED-020

## 1. Scope

- **Ticket:** REMED-020
- **Title:** Remediation review artifact does not contain runnable command evidence
- **Finding source:** EXEC-REMED-001
- **Source ticket:** MODEL-007 (split_scope child)
- **Stage:** planning

## 2. Assessment

### Root Cause of Finding

EXEC-REMED-001 claims the affected artifact lacks runnable command evidence. However, the affected artifact `remed-014-review-ticket-reconciliation.md` is a **ticket-reconciliation artifact**, not a review artifact. It was never supposed to contain runnable command evidence.

The actual review artifact that should be examined for EXEC-REMED-001 evidence is **`remed-010-review-review.md`**, which contains lines 22–88 of direct runnable command evidence (godot version checks, headless validation output, etc.). This artifact already satisfies the fix contract for EXEC-REMED-001.

### Prior Art

- **REMED-016:** Same mis-targeting issue — targeted a reconciliation artifact instead of the actual review artifact. Closed as superseded via `ticket_reconcile(supersede_target=true)`.
- **REMED-017:** Same finding, same mis-targeting pattern. Closed as superseded via `ticket_reconcile(supersede_target=true)`.

### Disposition

Since EXEC-REMED-001 is already resolved by existing evidence in `remed-010-review-review.md`, and REMED-020 suffers from the identical mis-targeting defect as REMED-016 and REMED-017, the correct disposition is **supersession via `ticket_reconcile`** with `supersede_target=true`.

## 3. Implementation Steps

| Step | Action | Detail |
|------|--------|--------|
| 1 | Confirm affected artifact | `remed-014-review-ticket-reconciliation.md` is a ticket-reconciliation artifact, not a review artifact |
| 2 | Confirm authoritative evidence | `remed-010-review-review.md` (lines 22–88) already contains runnable command evidence for EXEC-REMED-001 |
| 3 | Confirm prior art | REMED-016 and REMED-017 used identical supersession disposition |
| 4 | Call `ticket_reconcile` | `source_ticket_id=REMED-010`, `target_ticket_id=REMED-020`, `supersede_target=true`, `reason="mis-targeted at reconciliation artifact; finding already resolved by evidence in remed-010-review-review.md lines 22-88"` |
| 5 | Write reconciliation artifact | Document the mis-targeting analysis, prior art, and supersession rationale |
| 6 | Close REMED-020 as superseded | No implementation work required |

## 4. Acceptance Criteria Mapping

| AC | Description | Evidence |
|----|-------------|----------|
| AC-1 | EXEC-REMED-001 no longer reproduces | Finding is mis-targeted; authoritative evidence in `remed-010-review-review.md` (lines 22–88) already satisfies the fix contract |
| AC-2 | Review artifact contains runnable command evidence | `remed-010-review-review.md` contains exact command runs, raw output, and explicit PASS/FAIL results |

Both ACs are satisfied by existing evidence. No new implementation work is required.

## 5. Risks and Assumptions

| Risk | Assessment |
|------|------------|
| Backlog verifier reopens this finding against the wrong artifact | Low — same pattern resolved by REMED-016 and REMED-017 |
| `ticket_reconcile` with `supersede_target=true` does not close the ticket | Low — REMED-016 and REMED-017 precedent confirms this works |

## 6. Blockers

None. Bootstrap is ready. The finding is stale and mis-targeted.

## 7. Decision

**Adopt Option A:** Supersede REMED-020 via `ticket_reconcile(supersede_target=true)` — same disposition as REMED-016 and REMED-017. No implementation work needed.
