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

- plan: .opencode/state/artifacts/history/core-005/planning/2026-04-17T14-17-35-303Z-plan.md (planning) [superseded] - Planning artifact for CORE-005: 3D collision and damage system. Covers collision layer configuration (layers 1/2/3), script additions (player take_damage + health, player hit flash, enemy hit flash, death handling), 8-step implementation, AC mapping to 6 criteria, risk register (friendly fire guard, invincibility timing, death tween), and zero blockers. All dependencies (CORE-001, CORE-002, SETUP-001, SETUP-002) are done/trusted.
- plan: .opencode/state/artifacts/history/core-005/planning/2026-04-17T14-19-36-343Z-plan.md (planning) - Planning artifact for CORE-005: 3D collision and damage system. Covers collision layer configuration (layer 1=static, 3=enemies), player health system additions, attack→damage wiring, enemy contact→player damage, hit flash feedback, death handling, and 6-criterion AC mapping. All dependencies (CORE-001, CORE-002) are done/trusted. Zero blockers.
- review: .opencode/state/artifacts/history/core-005/review/2026-04-17T14-20-36-354Z-review.md (review) [superseded] - Review APPROVE for CORE-005: all 6 ACs mapped to verifiable evidence, scene structure sound for Godot 4.6, friendly fire guard explicitly addressed, no blockers. Implementation may proceed.
- review: .opencode/state/artifacts/history/core-005/review/2026-04-17T14-21-58-272Z-review.md (review) [superseded] - Review APPROVE for CORE-005: all 6 ACs mapped to verifiable evidence, scene structure sound for Godot 4.6, friendly fire guard explicitly addressed, no blockers. Implementation may proceed.
- environment-bootstrap: .opencode/state/artifacts/history/core-005/bootstrap/2026-04-17T14-23-09-793Z-environment-bootstrap.md (bootstrap) - Environment bootstrap completed successfully.
- implementation: .opencode/state/artifacts/history/core-005/implementation/2026-04-17T14-24-09-444Z-implementation.md (implementation) [superseded] - Implementation complete — all 8 steps PASS. Added collision layers (project.godot), health system + take_damage + hit signal wiring (player_controller.gd), hit flash scripts (PlayerHitFlash.gd, HitFlash.gd), updated player.tscn and horse_base.tscn with collision layers and nodes, wired Health.died → enemy death tween. Godot headless EXIT:0.
- implementation: .opencode/state/artifacts/history/core-005/implementation/2026-04-17T14-25-21-951Z-implementation.md (implementation) - 8-step implementation completing collision layers, player attack→enemy damage, enemy contact→player damage, hit flash feedback (PlayerHitFlash + HitFlash), death handling (player queue_free, enemy scale tween + queue_free), and friendly fire guards. Godot headless EXIT:0.
- review: .opencode/state/artifacts/history/core-005/review/2026-04-17T14-25-37-411Z-review.md (review) - Review APPROVE for CORE-005: all 6 ACs verified PASS, Godot headless EXIT:0, plan conformance 8/8 steps, no blockers.
- qa: .opencode/state/artifacts/history/core-005/qa/2026-04-17T14-26-51-654Z-qa.md (qa) [superseded] - QA validation passed — all 6 ACs verified PASS via executable evidence (grep, ls, godot4 headless EXIT:0)
- qa: .opencode/state/artifacts/history/core-005/qa/2026-04-17T14-27-12-335Z-qa.md (qa) - QA PASS — all 6 ACs verified with grep/shell evidence, godot headless EXIT:0
- smoke-test: .opencode/state/artifacts/history/core-005/smoke-test/2026-04-17T14-27-24-381Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test passed.
- smoke-test: .opencode/state/artifacts/history/core-005/smoke-test/2026-04-17T14-27-40-035Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test passed.
- smoke-test: .opencode/state/artifacts/history/core-005/smoke-test/2026-04-17T21-19-02-043Z-smoke-test.md (smoke-test) - Deterministic smoke test passed.
- backlog-verification: .opencode/state/artifacts/history/core-005/review/2026-04-17T21-19-47-825Z-backlog-verification.md (review) - Backlog verification PASS — all 6 ACs verified with current live executable evidence (godot4 --headless EXIT:0, grep evidence in QA artifact), no workflow drift, no material proof gaps. Trust restoration recommended for process version 7.
- reverification: .opencode/state/artifacts/history/core-005/review/2026-04-17T21-20-12-910Z-reverification.md (review) - Trust restored using CORE-005.

## Notes

- Read `godot-3d-android-game` skill for collision layer assignments
- Use signals for decoupled damage flow: attacker emits → target receives
- Invincibility frames after taking damage to prevent instant death

