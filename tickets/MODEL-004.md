# MODEL-004: Generate horse-war via Blender-MCP

## Summary

Generate armored war horse model via blender-agent MCP following assets/briefs/horse-war.md. Export GLB to assets/models/.

## Wave

1

## Lane

model-generation

## Parallel Safety

- parallel_safe: true
- overlap_risk: low

## Stage

review

## Status

review

## Trust

- resolution_state: open
- verification_state: suspect
- finding_source: None
- source_ticket_id: None
- source_mode: None

## Depends On

None

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] assets/models/horse-war.glb exists
- [ ] Triangle count ≤ 4000
- [ ] Manifold mesh, no inverted normals
- [ ] Imports into Godot without errors
- [ ] PROVENANCE.md entry added

## Artifacts

- plan: .opencode/state/artifacts/history/model-004/planning/2026-04-11T16-14-27-270Z-plan.md (planning) - Planning artifact for MODEL-004: Generate horse-war via Blender-MCP. Covers 11-step implementation workflow with 3-material PBR setup (gray body, red armor, dark trim), bulkier horse proportions, armor plate geometry (chamfron, peytral, flanks, shoulder guards), triangle budget strategy (≤4000), Blender MCP workaround plan for known bridge issues, quality validation approach, and full 5-criterion AC mapping.
- review: .opencode/state/artifacts/history/model-004/review/2026-04-11T16-16-09-927Z-review.md (review) [superseded] - Review APPROVE for MODEL-004: plan correctly applies Blender-MCP workarounds, all 5 ACs mapped, triangle budget realistic, no blockers.
- implementation: .opencode/state/artifacts/history/model-004/implementation/2026-04-11T16-21-46-873Z-implementation.md (implementation) - MODEL-004 blocked — Blender MCP bridge cannot forward input_blend/output_blend parameters to scene_batch_edit; same systemic BLENDER-MCP-CHAIN issue as MODEL-003; inline Python disabled by policy; all 5 ACs FAIL
- review: .opencode/state/artifacts/history/model-004/review/2026-04-11T16-22-46-995Z-review.md (review) - Review REJECT for MODEL-004: same BLENDER-MCP-CHAIN systemic blocker as MODEL-003; bridge does not forward input_blend/output_blend; all 5 ACs FAIL; managed blocker confirmed.
- ticket-reconciliation: .opencode/state/artifacts/history/model-004/review/2026-04-11T16-53-47-746Z-ticket-reconciliation.md (review) - Reconciled REMED-005 against MODEL-004.

## Notes

- Follow `blender-mcp-workflow` skill for exact tool sequence
- Read asset brief at `assets/briefs/horse-war.md`
- Armored variant — higher tri budget for armor detail
