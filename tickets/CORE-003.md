# CORE-003: Wave spawner (3D positions)

## Summary

Create the wave spawner system that manages enemy waves. Spawns enemies at 3D positions around the arena edges. Each wave has a defined count, composition (horse types), and spawn delay. Waves progress in difficulty. Emits signals for wave start, wave clear, and all waves complete.

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

- CORE-002

## Decision Blockers

- None

## Acceptance Criteria

- [ ] `scripts/enemies/wave_spawner.gd` exists
- [ ] Spawns enemies at randomized positions along arena edges (XZ plane)
- [ ] Wave data structure: count, enemy types, spawn delay
- [ ] At least 5 waves with progressive difficulty
- [ ] Emits `wave_started(wave_number)`, `wave_cleared`, `all_waves_complete` signals
- [ ] Spawns enemies into the EnemyContainer node
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- Spawn positions should be outside camera view but inside arena bounds
- Early waves: brown horses only. Later waves: mix of types. Boss in final wave.
- Use `godot-3d-android-game` skill for arena coordinate reference
