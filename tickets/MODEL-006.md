# MODEL-006: Generate arena-ground via Blender-MCP

## Summary

Use the blender-agent MCP server to generate the arena ground environment model following the asset brief at `assets/briefs/arena-ground.md`. Export as GLB to `assets/models/arena-ground.glb`. Validate and update PROVENANCE.md.

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

## Depends On

- None

## Decision Blockers

- None

## Acceptance Criteria

- [ ] `assets/models/arena-ground.glb` exists
- [ ] Triangle count ≤ 500 (verified by quality_validate)
- [ ] No inverted normals
- [ ] Manifold mesh
- [ ] Ground plane 20m × 20m, fence posts ~1m tall
- [ ] Green grass / brown wood materials match brief palette
- [ ] Reads clearly as fenced arena from top-down view
- [ ] Imports into Godot without errors
- [ ] `assets/PROVENANCE.md` entry added

## Artifacts

- None yet

## Notes

- Follow `blender-mcp-workflow` skill for exact tool sequence
- Read asset brief at `assets/briefs/arena-ground.md`
- SETUP-001 depends on this model for the arena scene
