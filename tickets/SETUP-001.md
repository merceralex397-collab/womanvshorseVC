# SETUP-001: Create 3D arena scene

## Summary

Create the main 3D arena scene with Node3D root, fixed top-down orthographic Camera3D, DirectionalLight3D, and arena-ground.glb model.

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

## Trust

- resolution_state: open
- verification_state: suspect
- finding_source: None
- source_ticket_id: None
- source_mode: None

## Depends On

MODEL-006

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] scenes/arena/arena.tscn exists with Node3D root
- [ ] Camera3D with orthographic projection
- [ ] DirectionalLight3D for sun lighting
- [ ] arena-ground.glb instanced as child
- [ ] Empty EnemyContainer Node3D for spawner
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- Read `godot-3d-android-game` skill for exact camera setup pattern
- Arena ground model must be generated first (MODEL-006)
