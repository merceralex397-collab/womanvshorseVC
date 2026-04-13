# CORE-005: 3D collision and damage system

## Summary

Connect player attacks to enemy health and enemy contact to player health with collision layers and damage signals.

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

## Trust

- resolution_state: open
- verification_state: suspect
- finding_source: None
- source_ticket_id: None
- source_mode: None

## Depends On

CORE-001, CORE-002

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] Collision layers configured correctly
- [ ] Player attacks damage enemies
- [ ] Enemy contact damages player
- [ ] Hit feedback (flash or knockback)
- [ ] Death handling for both player and enemies
- [ ] No friendly fire

## Artifacts

- None yet

## Notes

- Read `godot-3d-android-game` skill for collision layer assignments
- Use signals for decoupled damage flow: attacker emits → target receives
- Invincibility frames after taking damage to prevent instant death
