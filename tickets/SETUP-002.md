# SETUP-002: Create player controller

## Summary

Create the player character scene with CharacterBody3D root, CollisionShape3D, placeholder for woman-warrior.glb model, and a basic GDScript controller with virtual joystick movement on the XZ plane. Player moves with `move_and_slide()` and faces movement direction.

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

- SETUP-001

## Decision Blockers

- None

## Acceptance Criteria

- [ ] `scenes/player/player.tscn` exists with CharacterBody3D root
- [ ] CollisionShape3D child with capsule shape
- [ ] Script `scripts/player/player_controller.gd` attached to root
- [ ] Player moves on XZ plane via Input actions (move_left/right/up/down)
- [ ] Player faces movement direction using `look_at()`
- [ ] Placeholder Area3D "AttackArea" child for future attack system
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- Read `godot-3d-android-game` skill for CharacterBody3D movement pattern
- Woman warrior model can be added later when MODEL-001 completes
- Input actions must be defined in project.godot
