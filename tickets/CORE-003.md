# CORE-003: Wave spawner (3D positions)

## Summary

Create wave spawner that spawns enemy horses at 3D arena edge positions with progressive difficulty.

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

CORE-002

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] wave_spawner.gd exists
- [ ] Spawns at randomized arena edge positions
- [ ] At least 5 waves with progressive difficulty
- [ ] Signals for wave_started, wave_cleared, all_waves_complete
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- Spawn positions should be outside camera view but inside arena bounds
- Early waves: brown horses only. Later waves: mix of types. Boss in final wave.
- Use `godot-3d-android-game` skill for arena coordinate reference
