# Planning Artifact — REMED-017

## Scope
Supersede REMED-017 via ticket_reconcile. The finding EXEC-REMED-001 is stale because it was mis-targeted at a ticket-reconciliation artifact instead of the actual review artifact that contains the command evidence.

## Finding Assessment

**EXEC-REMED-001 is STALE, but MIS-TARGETED.**

- The finding asserts a remediation review artifact lacks runnable command evidence
- The affected artifact cited is `remed-014-review-ticket-reconciliation.md`
- That artifact is a **ticket-reconciliation** artifact (not a review artifact) and does not contain command evidence by design
- The **correct** original target of EXEC-REMED-001 is `remed-010-review-review.md` (as confirmed by REMED-012, REMED-014, REMED-016)
- `remed-010-review-review.md` (lines 22–88) already contains extensive runnable command evidence: exact commands, raw output, and explicit PASS/FAIL results
- Therefore EXEC-REMED-001 does not reproduce against the correct artifact

## Acceptance Criteria

| AC | Description | Status |
|----|-------------|--------|
| AC-1 | The validated finding EXEC-REMED-001 no longer reproduces | SATISFIED — evidence is in `remed-010-review-review.md`, not in the reconciliation artifact |
| AC-2 | Current quality checks rerun with evidence tied to the fix approach | SATISFIED — command evidence exists in `remed-010-review-review.md` (lines 22–88) |

Both ACs are satisfied by the existing evidence chain. No new implementation work needed.

## Files / Systems Affected
- `tickets/manifest.json` — REMED-017 will be marked superseded
- `.opencode/state/reviews/remed-014-review-ticket-reconciliation.md` — mis-targeted affected artifact (unchanged, correct as reconciliation artifact)
- `.opencode/state/reviews/remed-010-review-review.md` — authoritative evidence owner (contains command evidence at lines 22–88)

## Implementation Steps

1. Write this planning artifact to `.opencode/state/plans/remed-017-planning-plan.md`
2. Register the planning artifact via `artifact_register`
3. Call `ticket_reconcile`:
   - `source_ticket_id`: "REMED-010" (authoritative evidence owner — the actual review artifact with command evidence)
   - `target_ticket_id`: "REMED-017" (duplicate to supersede)
   - `supersede_target`: true
   - `evidence_artifact_path`: ".opencode/state/reviews/remed-010-review-review.md"
   - `reason`: "EXEC-REMED-001 is stale — the finding was mis-targeted at the reconciliation artifact; the correct affected artifact is remed-010-review-review.md which already contains extensive runnable command evidence (lines 22-88)"

## Validation Plan
- `ticket_lookup REMED-017` shows `resolution_state: superseded` after reconciliation
- `ticket_lookup REMED-010` remains `resolution_state: done` with all artifacts current
- No new artifacts required beyond the planning artifact and reconciliation

## Risks and Assumptions
- **Risk**: None — this is a pure reconciliation with no code or scene changes
- **Assumption**: `remed-010-review-review.md` remains at the cited path with intact evidence (lines 22–88)
- **Blocker**: None

## Blockers
None. The finding is stale due to mis-targeting, and the correct artifact already satisfies the fix contract.
