# CORE-002: Create 3D enemy horse base class

## Summary

Create the base enemy horse scene and script. CharacterBody3D root with CollisionShape3D, NavigationAgent3D for pathfinding toward the player, health system, and damage-on-contact via Area3D. This base class is shared by all horse variants (brown, black, war, boss) through model swapping and stat overrides.

## Wave

2

## Lane

core-gameplay

## Parallel Safety

- parallel_safe: false
- overlap_risk: medium

## Stage

planning

## Status

todo

## Depends On

- SETUP-001

## Decision Blockers

- None

## Acceptance Criteria

- [ ] `scenes/enemies/horse_base.tscn` exists with CharacterBody3D root
- [ ] `scripts/enemies/horse_base.gd` with exported stats (speed, health, damage, score_value)
- [ ] NavigationAgent3D child for pathfinding toward player
- [ ] Area3D hitbox on collision layer 4 (enemy attacks)
- [ ] Health system: takes damage, emits `died` signal at 0 HP
- [ ] Moves toward player position each frame
- [ ] Deals contact damage to player via Area3D overlap
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- Read `godot-3d-android-game` skill for enemy node hierarchy
- Export all stats so variants can override in inherited scenes or via script
- Model is swapped at runtime by variant system (CORE-006)
