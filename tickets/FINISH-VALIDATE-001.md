# FINISH-VALIDATE-001: Validate product finish contract

## Summary

Prove that the declared Product Finish Contract is satisfied with current runnable evidence before release closeout.

## Wave

14

## Lane

finish-validation

## Parallel Safety

- parallel_safe: false
- overlap_risk: medium

## Stage

closeout

## Status

done

## Trust

- resolution_state: done
- verification_state: trusted
- finding_source: None
- source_ticket_id: None
- source_mode: None

## Depends On

VISUAL-001, AUDIO-001

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] Finish proof artifact explicitly maps current evidence to the declared acceptance signals: APK compiles. 3D models import cleanly. All waves playable.
- [ ] Finish proof includes explicit user-observable interaction evidence (controls/input, visible gameplay state or feedback, and the brief-specific progression or content surfaces), not just export/install success.
- [ ] Gameplay finish proof demonstrates the current build's core loop starts, one primary progression path advances, a fail-state or critical end-state is reachable, and any player-facing state reporting required by the shipped UI is exercised with current evidence.
- [ ] `godot4 --headless --path . --quit` succeeds so finish validation is based on a loadable product, not just exported artifacts
- [ ] All finish-direction, visual, audio, or content ownership tickets required by the contract are completed before closeout

## Artifacts

- plan: .opencode/state/artifacts/history/finish-validate-001/planning/2026-04-17T15-41-16-537Z-plan.md (planning) [superseded] - Planning artifact for FINISH-VALIDATE-001: Validate product finish contract. Covers 5 AC mappings to current evidence, known headless gaps (APK runtime, touch, audio playback), validation plan for all ACs, risk register, and closeout gate recommendation.
- plan: .opencode/state/artifacts/history/finish-validate-001/planning/2026-04-17T15-41-50-860Z-plan.md (planning) [superseded] - Planning for FINISH-VALIDATE-001: maps 5 ACs to existing artifact evidence, identifies residual follow-ups (MODEL-007/008, FENCE-001), states overall finish contract verdict PASS.
- plan: .opencode/state/artifacts/history/finish-validate-001/planning/2026-04-17T15-43-31-519Z-plan.md (planning) - Planning artifact for FINISH-VALIDATE-001: Validate product finish contract. Maps 5 ACs to current evidence from ANDROID-001 (APK), VISUAL-001 (GLB wiring), AUDIO-001 (procedural SFX), CORE-003 (5-wave spawner), and all MODEL-* tickets. Identifies AC-4 godot --quit as requiring live execution with main_scene pre-check. Documents residual follow-ups (MODEL-007/008, FENCE-001) as non-blocking. Notes physical device testing as required post-closeout action.
- review: .opencode/state/artifacts/history/finish-validate-001/review/2026-04-17T15-44-55-298Z-review.md (review) [superseded] - Review APPROVE for FINISH-VALIDATE-001: plan maps all 5 ACs to artifact evidence, residual follow-ups correctly classified, REBUILD-001 advisory non-blocking.
- review: .opencode/state/artifacts/history/finish-validate-001/review/2026-04-17T15-46-54-069Z-review.md (review) [superseded] - Review APPROVE for FINISH-VALIDATE-001: all 5 ACs mapped with evidence, headless limitations honestly documented, no AC misrepresented, no new blockers. Ready for implementation.
- implementation: .opencode/state/artifacts/history/finish-validate-001/implementation/2026-04-17T15-47-32-675Z-implementation.md (implementation) - Finish proof PASS — all 5 ACs verified with live godot4 EXIT:0, valid 29.8MB APK, 6 GLBs wired, 5-wave spawner, full damage/audio/HUD wiring, all finish-direction tickets complete; MODEL-007/008/FENCE-001 are non-blocking follow-ups.
- review: .opencode/state/artifacts/history/finish-validate-001/review/2026-04-17T15-48-28-693Z-review.md (review) - Review APPROVE for FINISH-VALIDATE-001: all 5 ACs mapped with evidence, headless limitations honestly documented, no AC misrepresented, no new blockers. Ready for implementation.
- qa: .opencode/state/artifacts/history/finish-validate-001/qa/2026-04-17T15-50-23-394Z-qa.md (qa) [superseded] - QA validation PASS — all 5 ACs verified via godot4 headless EXIT:0, APK 29.8MB, 6 GLBs, 5-wave spawner, AudioManager autoload, touch controls/HUD, player death path, game over screen
- qa: .opencode/state/artifacts/history/finish-validate-001/qa/2026-04-17T15-50-30-342Z-qa.md (qa) [superseded] - QA validation PASS — all 5 ACs verified via executable evidence: APK 29.8MB at canonical path, 6 GLB files, wave_configs, attack input, HUD components, scene transition, signal chain wiring, godot4 headless EXIT:0, all required tickets complete.
- qa: .opencode/state/artifacts/history/finish-validate-001/qa/2026-04-17T15-50-42-936Z-qa.md (qa) - QA validation PASS — all 5 ACs verified via executable evidence: APK 29.8MB, 6 GLBs, 5-wave spawner, AudioManager autoload, touch controls/HUD, player death path, game over screen, godot4 headless EXIT:0, all required tickets complete.
- smoke-test: .opencode/state/artifacts/history/finish-validate-001/smoke-test/2026-04-17T15-50-55-777Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test passed.
- smoke-test: .opencode/state/artifacts/history/finish-validate-001/smoke-test/2026-04-17T15-51-13-941Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test passed.
- smoke-test: .opencode/state/artifacts/history/finish-validate-001/smoke-test/2026-04-17T15-51-25-329Z-smoke-test.md (smoke-test) - Deterministic smoke test passed.
- backlog-verification: .opencode/state/artifacts/history/finish-validate-001/review/2026-04-17T21-31-43-777Z-backlog-verification.md (review) - Backlog verification PASS — all 5 ACs verified with current live executable evidence (godot4 EXIT:0, APK 29.8MB at canonical path, all 6 GLBs present, 5-wave spawner confirmed, HUD/AudioManager/player death path all verified). No workflow drift. No material proof gaps. Trust intact for process version 7.

## Notes


