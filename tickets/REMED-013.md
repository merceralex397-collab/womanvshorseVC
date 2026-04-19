# REMED-013: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract

## Summary

Remediate EXEC-BLENDER-001 by correcting the validated issue and rerunning the relevant quality checks. Affected surfaces: .opencode/meta/asset-pipeline-bootstrap.json, assets/pipeline.json, .blender-mcp/audit/audit_20260409.jsonl, .blender-mcp/audit/audit_20260410.jsonl, .blender-mcp/audit/audit_20260411.jsonl, .blender-mcp/audit/audit_20260417.jsonl.

## Wave

19

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
- source_ticket_id: REMED-014
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

- plan: .opencode/state/artifacts/history/remed-013/planning/2026-04-17T11-00-51-048Z-plan.md (planning) - Planning artifact for REMED-013: finding EXEC-BLENDER-001 is stale — already resolved by REMED-009 (AC-1 and AC-2 both PASS, audit log confirmed non-null blend paths, smoke-test passed, backlog verification complete). Plan proposes ticket_reconcile with supersede_target:true to close REMED-013 as duplicative.

## Notes


