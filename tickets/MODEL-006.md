# MODEL-006: Generate arena-ground via Blender-MCP

## Summary

Generate arena ground environment model via blender-agent MCP following assets/briefs/arena-ground.md. Export GLB to assets/models/.

## Wave

1

## Lane

model-generation

## Parallel Safety

- parallel_safe: true
- overlap_risk: low

## Stage

planning

## Status

todo

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

- [ ] assets/models/arena-ground.glb exists
- [ ] Triangle count ≤ 500
- [ ] Manifold mesh, no inverted normals
- [ ] Imports into Godot without errors
- [ ] PROVENANCE.md entry added

## Artifacts

- None yet

## Notes

- Follow `blender-mcp-workflow` skill for exact tool sequence
- Read asset brief at `assets/briefs/arena-ground.md`
- SETUP-001 depends on this model for the arena scene
