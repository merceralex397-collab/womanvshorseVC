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

closeout

## Status

done

## Trust

- resolution_state: done
- verification_state: reverified
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

- plan: .opencode/state/artifacts/history/core-003/planning/2026-04-17T13-52-55-308Z-plan.md (planning) [superseded] - Planning artifact for CORE-003: Wave spawner (3D positions). Covers scene structure (Node3D root + Timer), script design (wave_spawner.gd with state machine, 5-wave configs, signals, spawn logic, alive tracking), progressive difficulty table, arena edge position randomization, signal wiring (HorseBase.died → _on_enemy_died), AC mapping table, 11-step implementation, 6-step validation plan, risk register, and zero blockers.
- plan: .opencode/state/artifacts/history/core-003/planning/2026-04-17T13-52-57-662Z-plan.md (planning) - Planning artifact for CORE-003: Wave spawner (3D positions). Covers scene structure (WaveSpawner Node3D with Timer), script design (edge spawn randomization, 5+ wave config, state machine), AC mapping to 5 criteria, 6-step implementation, validation plan, risk register (arena bounds, enemy death signals, nav agent timing), and zero blockers.
- review: .opencode/state/artifacts/history/core-003/review/2026-04-17T13-54-04-236Z-review.md (review) [superseded] - Review APPROVE for CORE-003: all 5 ACs mapped to verifiable evidence, scene structure sound for Godot 4.6, state machine correctly designed, signal design correct, arena edge randomization correct, 5-wave progressive difficulty table complete, alive_enemies counter and died signal wiring correct, no blocking blockers.
- review: .opencode/state/artifacts/history/core-003/review/2026-04-17T13-55-05-964Z-review.md (review) - Review APPROVE for CORE-003: all 5 ACs mapped to verifiable evidence, CORE-002 dependency confirmed via horse_base.gd, EnemyContainer confirmed in arena.tscn, no blocking defects. Advisory: set_speed()/set_max_health() need direct property assignment in implementation (not plan defect).
- implementation: .opencode/state/artifacts/history/core-003/implementation/2026-04-17T13-57-33-529Z-implementation.md (implementation) [superseded] - Implementation complete — all 5 ACs PASS. Created wave_spawner.tscn (Node3D + SpawnTimer) and wave_spawner.gd (state machine, 5-wave configs, edge randomization, died signal wiring, all 3 signals). Updated arena.tscn to include WaveSpawner. Godot v4.6.1 headless EXIT:0.
- implementation: .opencode/state/artifacts/history/core-003/implementation/2026-04-17T13-57-41-213Z-implementation.md (implementation) - Implementation complete — all 5 ACs PASS. Created wave_spawner.tscn (Node3D + SpawnTimer) and wave_spawner.gd (state machine, 5-wave configs, edge randomization, died signal wiring, all 3 signals). Godot v4.6.1 headless EXIT:0.
- qa: .opencode/state/artifacts/history/core-003/qa/2026-04-17T13-59-37-697Z-qa.md (qa) - QA validation passed — all 5 ACs verified PASS via executable evidence (file checks, grep, godot4 headless EXIT:0)
- smoke-test: .opencode/state/artifacts/history/core-003/smoke-test/2026-04-17T13-59-56-147Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test passed.
- smoke-test: .opencode/state/artifacts/history/core-003/smoke-test/2026-04-17T21-15-54-165Z-smoke-test.md (smoke-test) - Deterministic smoke test passed.
- backlog-verification: .opencode/state/artifacts/history/core-003/review/2026-04-17T21-16-28-010Z-backlog-verification.md (review) - Backlog verification PASS — all 5 ACs verified with live executable evidence, no workflow drift, no material proof gaps. Trust restoration recommended for process version 7.
- reverification: .opencode/state/artifacts/history/core-003/review/2026-04-17T21-16-37-909Z-reverification.md (review) - Trust restored using CORE-003.

## Notes

- Spawn positions should be outside camera view but inside arena bounds
- Early waves: brown horses only. Later waves: mix of types. Boss in final wave.
- Use `godot-3d-android-game` skill for arena coordinate reference

