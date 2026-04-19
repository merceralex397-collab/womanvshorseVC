# REMED-010: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract

## Summary

Remediate EXEC-BLENDER-001 by correcting the validated issue and rerunning the relevant quality checks. Affected surfaces: .opencode/meta/asset-pipeline-bootstrap.json, assets/pipeline.json, .blender-mcp/audit/audit_20260409.jsonl, .blender-mcp/audit/audit_20260410.jsonl, .blender-mcp/audit/audit_20260411.jsonl, .blender-mcp/audit/audit_20260417.jsonl.

## Wave

16

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
- finding_source: EXEC-BLENDER-001
- source_ticket_id: MODEL-004
- source_mode: split_scope

## Depends On

None

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] The validated finding `EXEC-BLENDER-001` no longer reproduces.
- [ ] Current quality checks rerun with evidence tied to the fix approach: Before escalating a Blender-MCP defect, prove one correct chain: `project_initialize(output_blend=...)`, then a mutating follow-up that reuses the returned `persistence.saved_blend` as `input_blend`, and verify `.blender-mcp/audit/*.jsonl` records non-null `input_blend` / `output_blend` on the matching `job_start`.

## Artifacts

- plan: .opencode/state/artifacts/history/remed-010/planning/2026-04-17T09-35-31-127Z-plan.md (planning) - Planning artifact for REMED-010: proposes supersession via ticket_reconcile since EXEC-BLENDER-001 is stale (resolved by REMED-009 and MODEL-003 evidence). Covers scope, assessment, decision rationale, implementation steps, AC mapping, risks, and blockers.
- review: .opencode/state/artifacts/history/remed-010/review/2026-04-17T09-38-18-265Z-review.md (review) - Review APPROVE for REMED-010: EXEC-BLENDER-001 is stale, supersession via ticket_reconcile with supersede_target:true is correct disposition. Both ACs resolved by REMED-009 and MODEL-003 evidence.
- ticket-reconciliation: .opencode/state/artifacts/history/remed-010/review/2026-04-17T10-57-02-087Z-ticket-reconciliation.md (review) [superseded] - Reconciled REMED-014 against REMED-010.
- ticket-reconciliation: .opencode/state/artifacts/history/remed-010/review/2026-04-17T13-29-12-361Z-ticket-reconciliation.md (review) [superseded] - Reconciled REMED-016 against REMED-010.
- ticket-reconciliation: .opencode/state/artifacts/history/remed-010/review/2026-04-17T13-31-54-146Z-ticket-reconciliation.md (review) [superseded] - Reconciled REMED-017 against REMED-010.
- ticket-reconciliation: .opencode/state/artifacts/history/remed-010/review/2026-04-17T16-45-33-640Z-ticket-reconciliation.md (review) [superseded] - Reconciled REMED-019 against REMED-010.
- ticket-reconciliation: .opencode/state/artifacts/history/remed-010/review/2026-04-17T16-47-53-425Z-ticket-reconciliation.md (review) - Reconciled REMED-020 against REMED-010.

## Notes


