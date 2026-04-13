# SETUP-002: Create player controller

## Summary

Create the player character scene with CharacterBody3D, CollisionShape3D, and GDScript controller with XZ movement.

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

SETUP-001

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] scenes/player/player.tscn exists with CharacterBody3D root
- [ ] player_controller.gd with move_and_slide movement
- [ ] Placeholder AttackArea Area3D child
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- Read `godot-3d-android-game` skill for CharacterBody3D movement pattern
- Woman warrior model can be added later when MODEL-001 completes
- Input actions must be defined in project.godot
