# MODEL-003: Generate horse-black via Blender-MCP

## Summary

Generate black horse enemy model via blender-agent MCP following assets/briefs/horse-black.md. Export GLB to assets/models/.

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

- [ ] assets/models/horse-black.glb exists
- [ ] Triangle count ≤ 2000
- [ ] Manifold mesh, no inverted normals
- [ ] Imports into Godot without errors
- [ ] PROVENANCE.md entry added

## Artifacts

- plan: .opencode/state/artifacts/history/model-003/planning/2026-04-10T12-20-16-695Z-plan.md (planning) - Planning artifact for MODEL-003: Generate horse-black via Blender-MCP. Covers 11-step implementation (probe → scene init → geometry build → refine → mesh cleanup → materials → UV → preview → quality validate → GLB export → godot import → provenance), quality validation plan, risk register, and 5-criterion AC mapping.
- implementation: .opencode/state/artifacts/history/model-003/implementation/2026-04-10T22-03-42-108Z-implementation.md (implementation) - MODEL-003 blocked — Blender MCP stateless bridge cannot chain scene_batch_edit operations. 20+ calls confirmed: create_primitive auto-names objects as Cube.XXX ignoring the object parameter; set_transform fails to find user-specified names; output_blend=null never persists scene state; --factory-startup always starts fresh. Inline Python disabled. Remediation ticket needed.
- review: .opencode/state/artifacts/history/model-003/review/2026-04-11T15-59-36-725Z-review.md (review) - Review REJECT for MODEL-003: all 5 ACs fail. Blender MCP stateless bridge cannot chain scene_batch_edit operations. Root cause confirmed at bridge level. Managed blocker. REMED-003 split child created.
- ticket-reconciliation: .opencode/state/artifacts/history/model-003/review/2026-04-11T16-53-47-159Z-ticket-reconciliation.md (review) [superseded] - Reconciled REMED-003 against MODEL-003.
- ticket-reconciliation: .opencode/state/artifacts/history/model-003/review/2026-04-11T16-53-47-449Z-ticket-reconciliation.md (review) - Reconciled REMED-004 against MODEL-003.

## Notes

- Follow `blender-mcp-workflow` skill for exact tool sequence
- Read asset brief at `assets/briefs/horse-black.md`
- Fast enemy variant — slimmer proportions than brown horse
