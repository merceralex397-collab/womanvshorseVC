# REMED-009: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract

## Summary

Remediate EXEC-BLENDER-001 by correcting the validated issue and rerunning the relevant quality checks. Affected surfaces: .opencode/meta/asset-pipeline-bootstrap.json, assets/pipeline.json, .blender-mcp/audit/audit_20260409.jsonl, .blender-mcp/audit/audit_20260410.jsonl, .blender-mcp/audit/audit_20260411.jsonl.

## Wave

15

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

- resolution_state: done
- verification_state: reverified
- finding_source: EXEC-BLENDER-001
- source_ticket_id: None
- source_mode: net_new_scope

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

- plan: .opencode/state/artifacts/history/remed-009/planning/2026-04-17T02-19-23-295Z-plan.md (planning) - Planning artifact for REMED-009: covers EXEC-BLENDER-001 root cause analysis, audit log evidence confirming null input_blend on all job_start records, 5-step approach to prove correct chaining chain, AC mapping, risks, and a BRIDGE-DEFECT blocker requiring bridge repair before the ticket can close.
- environment-bootstrap: .opencode/state/artifacts/history/remed-009/bootstrap/2026-04-17T02-38-05-491Z-environment-bootstrap.md (bootstrap) - Environment bootstrap completed successfully.
- review: .opencode/state/artifacts/history/remed-009/review/2026-04-17T02-40-27-869Z-review.md (review) - Review REJECT for REMED-009: plan correctly diagnoses BRIDGE-DEFECT but 5-step approach is a diagnostic sequence that cannot produce AC-meeting closeout evidence without external bridge repair. AC reframing decision not made. No in-ticket repair path.
- implementation: .opencode/state/artifacts/history/remed-009/implementation/2026-04-17T02-59-02-043Z-implementation.md (implementation) [superseded] - Implementation evidence for REMED-009: blender-agent MCP chaining chain attempted. Bridge confirmed working as designed — requires explicit input_blend+output_blend on each call. Historical audit_20260410.jsonl proves chaining works when caller passes blend paths. AC-1 and AC-2 cannot be met without a pipeline script that implements the explicit chaining loop, or AC reframing. Root cause is caller responsibility, not bridge defect.
- implementation: .opencode/state/artifacts/history/remed-009/implementation/2026-04-17T03-03-08-803Z-implementation.md (implementation) - Complete chaining chain execution for REMED-009. Audit log confirms non-null input_blend/output_blend on job_start. Bridge works as designed. Root cause was caller not passing blend params, not bridge defect. AC-1 and AC-2 both PASS.
- qa: .opencode/state/artifacts/history/remed-009/qa/2026-04-17T03-06-27-301Z-qa.md (qa) - QA validation passed - all 4 checks verified PASS, both AC-1 and AC-2 mapped to audit log and implementation evidence
- smoke-test: .opencode/state/artifacts/history/remed-009/smoke-test/2026-04-17T03-06-51-310Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-009/smoke-test/2026-04-17T03-07-21-910Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-009/smoke-test/2026-04-17T03-07-34-895Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-009/smoke-test/2026-04-17T03-08-08-964Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-009/smoke-test/2026-04-17T03-08-23-239Z-smoke-test.md (smoke-test) - Deterministic smoke test passed.
- backlog-verification: .opencode/state/artifacts/history/remed-009/review/2026-04-17T10-58-29-884Z-backlog-verification.md (review) [superseded] - Backlog verification PASS — both ACs verified PASS via audit log evidence, smoke-test PASS. Trust intact for process version 7.
- backlog-verification: .opencode/state/artifacts/history/remed-009/review/2026-04-17T10-58-50-853Z-backlog-verification.md (review) - Backlog verification registered during ticket_reverify for REMED-009.
- reverification: .opencode/state/artifacts/history/remed-009/review/2026-04-17T10-58-50-853Z-reverification.md (review) - Trust restored using REMED-009.
- ticket-reconciliation: .opencode/state/artifacts/history/remed-009/review/2026-04-17T13-36-16-269Z-ticket-reconciliation.md (review) - Reconciled REMED-015 against REMED-009.

## Notes


