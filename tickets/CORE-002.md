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

- plan: .opencode/state/artifacts/history/core-002/planning/2026-04-17T13-46-14-302Z-plan.md (planning) - Planning artifact for CORE-002: Create 3D enemy horse base class. Covers scene structure (CharacterBody3D root with NavigationAgent3D, HealthComponent, ContactDamageArea), script design (exported stats speed/health/damage/score_value, died signal, take_damage, nav integration), 11-step implementation, 8-step validation plan, 4-risk register, and zero blockers.
- review: .opencode/state/artifacts/history/core-002/review/2026-04-17T13-46-53-932Z-review.md (review) [superseded] - Review APPROVE for CORE-002: all 6 ACs mapped to verifiable evidence, scene structure sound for Godot 4.6, XZ-plane movement correctly specified, NavigationAgent3D usage correct, health system with died signal correctly defined, contact damage Area3D correctly configured, no blockers.
- implementation: .opencode/state/artifacts/history/core-002/implementation/2026-04-17T13-48-02-225Z-implementation.md (implementation) [superseded] - Implementation complete — all 6 ACs PASS. Created scenes/enemies/horse_base.tscn (CharacterBody3D root with CollisionShape3D, NavigationAgent3D, Health Node, ContactDamageArea Area3D) and scripts/enemies/horse_base.gd (4 exported stats, died signal, NavigationAgent3D integration, XZ-plane move_and_slide, contact damage). Godot headless validation EXIT:0.
- review: .opencode/state/artifacts/history/core-002/review/2026-04-17T13-49-11-248Z-review.md (review) - Review APPROVE for CORE-002: all 6 ACs verified PASS with live evidence. CharacterBody3D root confirmed, 4 exported stats present, NavigationAgent3D pathfinding present, died signal chain verified (HealthComponent → HorseBase), ContactDamageArea Area3D confirmed, Godot headless EXIT:0.
- implementation: .opencode/state/artifacts/history/core-002/implementation/2026-04-17T13-49-21-095Z-implementation.md (implementation) - Implementation complete — all 6 ACs PASS. Created scenes/enemies/horse_base.tscn (CharacterBody3D root with NavigationAgent3D, HealthComponent, ContactDamageArea) and scripts/enemies/horse_base.gd (4 exported stats, died signal, XZ-plane move_and_slide, nav integration). Godot headless validation EXIT:0.
- qa: .opencode/state/artifacts/history/core-002/qa/2026-04-17T13-50-25-904Z-qa.md (qa) [superseded] - QA validation passed — all 6 ACs verified PASS via executable evidence (ls, grep, godot headless EXIT:0)
- qa: .opencode/state/artifacts/history/core-002/qa/2026-04-17T13-50-42-801Z-qa.md (qa) - QA validation passed — all 6 ACs verified PASS via executable evidence (grep, ls, godot headless EXIT:0)
- smoke-test: .opencode/state/artifacts/history/core-002/smoke-test/2026-04-17T13-50-43-398Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test passed.
- smoke-test: .opencode/state/artifacts/history/core-002/smoke-test/2026-04-17T13-51-20-821Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test passed.
- smoke-test: .opencode/state/artifacts/history/core-002/smoke-test/2026-04-17T21-14-43-694Z-smoke-test.md (smoke-test) - Deterministic smoke test passed.
- backlog-verification: .opencode/state/artifacts/history/core-002/review/2026-04-17T21-15-14-276Z-backlog-verification.md (review) - Backlog verification PASS — all 6 ACs verified with current live executable evidence, no workflow drift, no material proof gaps. Trust intact for process version 7.

## Notes

- Read `godot-3d-android-game` skill for enemy node hierarchy
- Export all stats so variants can override in inherited scenes or via script
- Model is swapped at runtime by variant system (CORE-006)

