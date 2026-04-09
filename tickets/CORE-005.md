# CORE-005: 3D collision and damage system

## Summary

Implement the collision and damage system connecting player attacks to enemy health and enemy contact to player health. Set up collision layers and masks correctly. Create a shared damage interface using signals. Player and enemy health components react to damage events.

## Wave

2

## Lane

core-gameplay

## Parallel Safety

- parallel_safe: false
- overlap_risk: high

## Stage

planning

## Status

todo

## Depends On

- CORE-001
- CORE-002

## Decision Blockers

- None

## Acceptance Criteria

- [ ] Collision layers configured: Player=1, Enemies=2, PlayerAttacks=3, EnemyAttacks=4, Boundaries=5
- [ ] Player attack Area3D detects and damages enemies
- [ ] Enemy contact Area3D detects and damages player
- [ ] Damage values configurable per attacker
- [ ] Hit feedback: flash or knockback on damage
- [ ] Player death triggers game over flow
- [ ] Enemy death removes from scene and awards score
- [ ] No friendly fire (player doesn't hit self, enemies don't hit each other)

## Artifacts

- None yet

## Notes

- Read `godot-3d-android-game` skill for collision layer assignments
- Use signals for decoupled damage flow: attacker emits → target receives
- Invincibility frames after taking damage to prevent instant death
