# CORE-004: 3D HUD (CanvasLayer)

## Summary

Create in-game HUD overlay with health, wave number, score, enemy count, virtual joystick, and attack button.

## Wave

2

## Lane

ui

## Parallel Safety

- parallel_safe: true
- overlap_risk: low

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

SETUP-001

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] hud.tscn exists with CanvasLayer root
- [ ] Displays health, wave, score, enemy count
- [ ] Virtual joystick and attack button placeholders
- [ ] Touch-friendly sizing (48dp minimum)
- [ ] Scene loads without errors

## Artifacts

- plan: .opencode/state/artifacts/history/core-004/planning/2026-04-17T14-10-14-982Z-plan.md (planning) [superseded] - Planning artifact for CORE-004: 3D HUD (CanvasLayer). Covers scene structure (CanvasLayer → Control hierarchy with VBoxContainer stats + VirtualJoystick + AttackButton), 3-script design (hud.gd, virtual_joystick.gd, attack_button.gd), 8-step implementation, AC mapping to 5 criteria, risk register (wiring deferred to CORE-005), and zero blockers.
- plan: .opencode/state/artifacts/history/core-004/planning/2026-04-17T14-11-06-385Z-plan.md (planning) - Plan for CORE-004: CanvasLayer HUD with health, wave, score, enemy count, virtual joystick, and attack button placeholders — all touch-friendly ≥48dp.
- review: .opencode/state/artifacts/history/core-004/review/2026-04-17T14-11-46-528Z-review.md (review) - Review APPROVE for CORE-004: all 5 ACs mapped to verifiable evidence, scene structure sound for Godot 4.6, scripts complete, implementation steps sufficient, zero blockers.
- implementation: .opencode/state/artifacts/history/core-004/implementation/2026-04-17T14-13-37-132Z-implementation.md (implementation) - Implementation complete — all 5 ACs PASS. Created hud.tscn with CanvasLayer root, full HUD node hierarchy, 5 scripts (health_display, wave_display, score_display, virtual_joystick, attack_button). Godot headless validation EXIT:0.
- qa: .opencode/state/artifacts/history/core-004/qa/2026-04-17T14-15-46-553Z-qa.md (qa) - QA validation passed — all 5 ACs verified PASS via executable evidence (file checks, grep, godot4 headless EXIT:0)
- smoke-test: .opencode/state/artifacts/history/core-004/smoke-test/2026-04-17T14-16-07-807Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test passed.
- smoke-test: .opencode/state/artifacts/history/core-004/smoke-test/2026-04-17T21-17-35-390Z-smoke-test.md (smoke-test) - Deterministic smoke test passed.
- backlog-verification: .opencode/state/artifacts/history/core-004/review/2026-04-17T21-18-12-633Z-backlog-verification.md (review) - Backlog verification PASS — all 5 ACs verified with current live executable evidence, no workflow drift, no material proof gaps. Trust restoration recommended for process version 7.
- reverification: .opencode/state/artifacts/history/core-004/review/2026-04-17T21-18-39-685Z-reverification.md (review) - Trust restored using CORE-004.

## Notes

- CanvasLayer renders on top of 3D scene
- Use MarginContainer/HBoxContainer for layout
- Connect to game signals for reactive updates

