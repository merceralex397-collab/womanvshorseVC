# MODEL-003: Generate horse-black via Blender-MCP

## Summary

Use the blender-agent MCP server to generate the fast black horse enemy model following the asset brief at `assets/briefs/horse-black.md`. Export as GLB to `assets/models/horse-black.glb`. Validate and update PROVENANCE.md.

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

- [ ] `assets/models/horse-black.glb` exists
- [ ] Triangle count ≤ 2000 (verified by quality_validate)
- [ ] No inverted normals
- [ ] Manifold mesh
- [ ] Scale ~1.5m tall at head
- [ ] Black body with red eye accent match brief palette
- [ ] Visually distinct from horse-brown (sleeker silhouette)
- [ ] Imports into Godot without errors
- [ ] `assets/PROVENANCE.md` entry added

## Artifacts

- None yet

## Notes

- Follow `blender-mcp-workflow` skill for exact tool sequence
- Read asset brief at `assets/briefs/horse-black.md`
- Fast enemy variant — slimmer proportions than brown horse
