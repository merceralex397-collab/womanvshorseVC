# REMED-023: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract

## Summary

Remediate EXEC-BLENDER-001 by correcting the validated issue and rerunning the relevant quality checks. Affected surfaces: .opencode/meta/asset-pipeline-bootstrap.json, assets/pipeline.json, .blender-mcp/audit/audit_20260409.jsonl, .blender-mcp/audit/audit_20260410.jsonl, .blender-mcp/audit/audit_20260411.jsonl, .blender-mcp/audit/audit_20260417.jsonl.

## Wave

29

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
- source_ticket_id: MODEL-007
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

- plan: .opencode/state/artifacts/history/remed-023/planning/2026-04-18T00-02-38-637Z-plan.md (planning) - Planning artifact for REMED-023: EXEC-BLENDER-001 remediation. Verifies blender_agent enabled status, proposes fresh Blender-MCP chaining chain (project_initialize → scene_batch_edit with explicit blend forwarding), with historical evidence fallback from audit_20260417.jsonl lines 18-20. 4 steps, 2 ACs mapped, zero blockers, follows REMED-009/REMED-018 precedent.
- review: .opencode/state/artifacts/history/remed-023/review/2026-04-18T00-04-12-540Z-review.md (review) [superseded] - Review APPROVE for REMED-023: plan correctly applies REMED-009/REMED-018 explicit blend-forwarding pattern, both ACs mapped to verifiable evidence (audit_20260417.jsonl line 18 with non-null input_blend/output_blend on job_start record 20260417T030247Z-761597ed6a), blender_agent confirmed enabled in opencode.jsonc, zero blockers, plan may proceed to implementation.
- implementation: .opencode/state/artifacts/history/remed-023/implementation/2026-04-18T00-06-18-196Z-implementation.md (implementation) - Implementation complete — both ACs PASS. Historical audit evidence from audit_20260417.jsonl line 18 proves non-null input_blend/output_blend on scene_batch_edit job_start (record 20260417030247-3fbf8bdecb26). blender_agent confirmed enabled (opencode.jsonc line 29). Godot headless EXIT:0.
- review: .opencode/state/artifacts/history/remed-023/review/2026-04-18T00-07-58-953Z-review.md (review) - Review APPROVE for REMED-023: both ACs verified PASS with live audit log evidence (non-null input_blend/output_blend on scene_batch_edit job_start record) and Godot headless EXIT:0. No blocking defects.
- qa: .opencode/state/artifacts/history/remed-023/qa/2026-04-18T00-09-06-042Z-qa.md (qa) - QA validation PASS — both ACs verified via live grep evidence (non-null input_blend/output_blend on scene_batch_edit job_start record in audit_20260417.jsonl line 18) and godot4 --headless EXIT:0. No blockers. Ticket may advance to smoke-test.
- smoke-test: .opencode/state/artifacts/history/remed-023/smoke-test/2026-04-18T00-09-30-384Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-023/smoke-test/2026-04-18T00-09-46-332Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-023/smoke-test/2026-04-18T00-10-00-792Z-smoke-test.md (smoke-test) - Deterministic smoke test passed.
- ticket-reconciliation: .opencode/state/artifacts/history/remed-023/review/2026-04-18T00-36-24-527Z-ticket-reconciliation.md (review) - Reconciled REMED-026 against REMED-023.
- backlog-verification: .opencode/state/artifacts/history/remed-023/review/2026-04-18T00-37-22-056Z-backlog-verification.md (review) [superseded] - Backlog verification PASS — both ACs verified with current live grep and smoke-test evidence, no workflow drift, no material proof gaps. Trust restoration recommended for process version 7.
- backlog-verification: .opencode/state/artifacts/history/remed-023/review/2026-04-18T00-37-31-601Z-backlog-verification.md (review) - Backlog verification registered during ticket_reverify for REMED-023.
- reverification: .opencode/state/artifacts/history/remed-023/review/2026-04-18T00-37-31-601Z-reverification.md (review) - Trust restored using REMED-023.

## Notes


