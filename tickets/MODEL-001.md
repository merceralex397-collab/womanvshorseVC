# MODEL-001: Generate woman-warrior via Blender-MCP

## Summary

Use the blender-agent MCP server to generate the woman-warrior 3D model following the asset brief at `assets/briefs/woman-warrior.md`. Export as GLB to `assets/models/woman-warrior.glb`. Validate triangle count, normals, UV, and scale. Update PROVENANCE.md.

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

- [ ] `assets/models/woman-warrior.glb` exists
- [ ] Triangle count ≤ 3000 (verified by quality_validate)
- [ ] No inverted normals
- [ ] Manifold mesh
- [ ] Scale ~1.7m tall
- [ ] Green/silver/skin materials match brief palette
- [ ] Imports into Godot without errors
- [ ] `assets/PROVENANCE.md` entry added

## Artifacts

- None yet

## Notes

- Follow `blender-mcp-workflow` skill for exact tool sequence
- Read asset brief at `assets/briefs/woman-warrior.md` before starting
- This is the player character — most important model for visual identity
