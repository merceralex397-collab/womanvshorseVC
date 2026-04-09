# MODEL-005: Generate horse-boss via Blender-MCP

## Summary

Use the blender-agent MCP server to generate the boss horse model following the asset brief at `assets/briefs/horse-boss.md`. Export as GLB to `assets/models/horse-boss.glb`. Validate and update PROVENANCE.md.

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

- [ ] `assets/models/horse-boss.glb` exists
- [ ] Triangle count ≤ 5000 (verified by quality_validate)
- [ ] No inverted normals
- [ ] Manifold mesh
- [ ] Scale ~2.2m tall at head (visibly larger than other horses)
- [ ] Gold armor / dark body materials match brief palette
- [ ] Crown crest visible from top-down view
- [ ] Imports into Godot without errors
- [ ] `assets/PROVENANCE.md` entry added

## Artifacts

- None yet

## Notes

- Follow `blender-mcp-workflow` skill for exact tool sequence
- Read asset brief at `assets/briefs/horse-boss.md`
- Boss variant — largest model, most ornate, gold armor
