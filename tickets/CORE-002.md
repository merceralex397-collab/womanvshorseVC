# CORE-002: Create 3D enemy horse base class

## Summary

Create base enemy horse scene with CharacterBody3D, NavigationAgent3D, health system, and contact damage.

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

SETUP-001

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] horse_base.tscn exists with CharacterBody3D root
- [ ] horse_base.gd with exported stats
- [ ] NavigationAgent3D for pathfinding
- [ ] Health system with died signal
- [ ] Contact damage via Area3D
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- Read `godot-3d-android-game` skill for enemy node hierarchy
- Export all stats so variants can override in inherited scenes or via script
- Model is swapped at runtime by variant system (CORE-006)
