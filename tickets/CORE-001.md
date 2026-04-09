# CORE-001: Implement 3D attack system

## Summary

Create the attack system for the player character. The player has a melee sword attack triggered by a touch button. The attack uses an Area3D hitbox that detects overlapping enemy bodies. Attack has a cooldown timer. Deals damage to enemies via a signal. Optional: charge attack or projectile throw for ranged variant.

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

- SETUP-002

## Decision Blockers

- None

## Acceptance Criteria

- [ ] `scripts/player/attack_system.gd` exists
- [ ] Attack triggered by "attack" Input action
- [ ] Area3D hitbox activates on attack, detects collision layer 2 (enemies)
- [ ] Cooldown timer prevents attack spam
- [ ] Emits signal with damage value when hitting an enemy
- [ ] Attack animation placeholder (rotate model or flash effect)
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- Read `godot-3d-android-game` skill for collision layer setup
- Use Area3D `get_overlapping_bodies()` for hit detection
- Keep attack system decoupled from player controller via signals
