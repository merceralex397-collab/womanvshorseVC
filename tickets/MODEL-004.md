# MODEL-004: Generate horse-war via Blender-MCP

## Summary

Use the blender-agent MCP server to generate the armored war horse enemy model following the asset brief at `assets/briefs/horse-war.md`. Export as GLB to `assets/models/horse-war.glb`. Validate and update PROVENANCE.md.

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

- [ ] `assets/models/horse-war.glb` exists
- [ ] Triangle count ≤ 4000 (verified by quality_validate)
- [ ] No inverted normals
- [ ] Manifold mesh
- [ ] Scale ~1.7m tall at head
- [ ] Red armor / gray body materials match brief palette
- [ ] Armor plates visible from top-down view
- [ ] Imports into Godot without errors
- [ ] `assets/PROVENANCE.md` entry added

## Artifacts

- None yet

## Notes

- Follow `blender-mcp-workflow` skill for exact tool sequence
- Read asset brief at `assets/briefs/horse-war.md`
- Armored variant — higher tri budget for armor detail
