# MODEL-002: Generate horse-brown via Blender-MCP

## Summary

Use the blender-agent MCP server to generate the basic brown horse enemy model following the asset brief at `assets/briefs/horse-brown.md`. Export as GLB to `assets/models/horse-brown.glb`. Validate and update PROVENANCE.md.

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

- [ ] `assets/models/horse-brown.glb` exists
- [ ] Triangle count ≤ 2000 (verified by quality_validate)
- [ ] No inverted normals
- [ ] Manifold mesh
- [ ] Scale ~1.5m tall at head
- [ ] Brown/dark-brown materials match brief palette
- [ ] Imports into Godot without errors
- [ ] `assets/PROVENANCE.md` entry added

## Artifacts

- None yet

## Notes

- Follow `blender-mcp-workflow` skill for exact tool sequence
- Read asset brief at `assets/briefs/horse-brown.md`
- Most common enemy — appears in large groups
