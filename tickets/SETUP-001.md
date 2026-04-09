# SETUP-001: Create 3D arena scene

## Summary

Create the main 3D arena scene with Node3D root, fixed top-down orthographic Camera3D, DirectionalLight3D for sun lighting, and an empty Node3D container for enemies. Import arena-ground.glb as the ground plane. This is the foundational scene that all gameplay happens in.

## Wave

0

## Lane

scene-setup

## Parallel Safety

- parallel_safe: false
- overlap_risk: high

## Stage

planning

## Status

todo

## Depends On

- MODEL-006

## Decision Blockers

- None

## Acceptance Criteria

- [ ] `scenes/arena/arena.tscn` exists with Node3D root
- [ ] Camera3D child with orthographic projection, size ~20, position (0, 15, 0), rotation (-90, 0, 0)
- [ ] DirectionalLight3D child for sun lighting
- [ ] arena-ground.glb instanced as child
- [ ] Empty Node3D "EnemyContainer" for wave spawner to populate
- [ ] Scene loads without errors in `godot --headless --check-only --path .`

## Artifacts

- None yet

## Notes

- Read `godot-3d-android-game` skill for exact camera setup pattern
- Arena ground model must be generated first (MODEL-006)
