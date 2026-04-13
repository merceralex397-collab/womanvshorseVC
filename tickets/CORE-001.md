# CORE-001: Implement 3D attack system

## Summary

Create the player attack system with Area3D hitbox, cooldown timer, and damage signal.

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

## Trust

- resolution_state: open
- verification_state: suspect
- finding_source: None
- source_ticket_id: None
- source_mode: None

## Depends On

SETUP-002

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] attack_system.gd exists
- [ ] Area3D hitbox detects collision layer 2
- [ ] Cooldown timer prevents spam
- [ ] Damage signal emitted on hit
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- Read `godot-3d-android-game` skill for collision layer setup
- Use Area3D `get_overlapping_bodies()` for hit detection
- Keep attack system decoupled from player controller via signals
