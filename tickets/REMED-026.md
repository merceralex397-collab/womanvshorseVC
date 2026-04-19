# REMED-026: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract

## Summary

Remediate EXEC-BLENDER-001 by correcting the validated issue and rerunning the relevant quality checks. Affected surfaces: .opencode/meta/asset-pipeline-bootstrap.json, assets/pipeline.json, .blender-mcp/audit/audit_20260409.jsonl, .blender-mcp/audit/audit_20260410.jsonl, .blender-mcp/audit/audit_20260411.jsonl, .blender-mcp/audit/audit_20260417.jsonl.

## Wave

32

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
- source_ticket_id: REMED-023
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

- plan: .opencode/state/artifacts/history/remed-026/planning/2026-04-18T00-35-18-274Z-plan.md (planning) - Planning artifact for REMED-026: EXEC-BLENDER-001 is stale — authoritative non-null input_blend/output_blend evidence already exists in REMED-023's implementation artifact (audit_20260417.jsonl line 18). Both ACs satisfied by existing evidence. Plan proposes ticket_reconcile with supersede_target:true. Same disposition as parallel-independent split siblings REMED-012/016/017/019/020/021/022. Zero blockers.

## Notes


