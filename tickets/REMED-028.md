# REMED-028: Remediation review artifact does not contain runnable command evidence

## Summary

Remediate EXEC-REMED-001 by correcting the validated issue and rerunning the relevant quality checks. Affected surfaces: tickets/manifest.json, .opencode/state/reviews/remed-014-review-ticket-reconciliation.md.

## Wave

34

## Lane

remediation

## Parallel Safety

- parallel_safe: false
- overlap_risk: low

## Stage

closeout

## Status

done

## Trust

- resolution_state: superseded
- verification_state: reverified
- finding_source: EXEC-REMED-001
- source_ticket_id: REMED-002
- source_mode: split_scope

## Depends On

None

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] The validated finding `EXEC-REMED-001` no longer reproduces.
- [ ] Current quality checks rerun with evidence tied to the fix approach: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.

## Artifacts

- plan: .opencode/state/artifacts/history/remed-028/planning/2026-04-18T00-44-33-198Z-plan.md (planning) - Planning artifact for REMED-028: EXEC-REMED-001 is stale — authoritative runnable command evidence already exists in remed-002-review-review.md lines 22-88. Plan proposes ticket_reconcile with supersede_target:true. Both ACs mapped to existing evidence. Zero blockers. Same disposition as sibling superseded tickets REMED-012/016/017/019/020/021/022/024/025/027.

## Notes


