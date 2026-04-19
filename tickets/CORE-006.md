# CORE-006: Enemy variants with model swapping

## Summary

Create variant system that configures horse_base with different GLB models and stats for brown, black, war, and boss types.

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

CORE-002, MODEL-001, MODEL-002, MODEL-003, MODEL-004, MODEL-005

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] horse_variants.gd with variant definitions
- [ ] Each variant: model_path, speed, health, damage, score_value
- [ ] horse_base loads correct GLB at runtime
- [ ] Wave spawner can request variant types
- [ ] All models load without errors

## Artifacts

- plan: .opencode/state/artifacts/history/core-006/planning/2026-04-17T14-29-55-356Z-plan.md (planning) [superseded] - Planning artifact for CORE-006: Enemy variants with model swapping. Covers variant system design using horse_variants.gd dictionary, MeshInstance3D GLB loading in horse_base.gd, wave spawner variant dispatch via config["variant"] key, AC-5 mapping to 5 criteria, validation plan (grep + godot headless), risk register (GLB structure, variant fallback), and zero blockers confirmation.
- plan: .opencode/state/artifacts/history/core-006/planning/2026-04-17T14-30-23-827Z-plan.md (planning) [superseded] - Planning artifact for CORE-006: Enemy variants with model swapping. Covers variant definitions (brown/black/war/boss with model_path+speed+health+damage+score_value), GLB runtime loading via GLTFDocument in horse_base.gd, variant-aware wave_spawner.gd wiring, AC mapping to 5 criteria, 8-step validation plan, risk register (7 entries), and zero blockers. All dependencies done/trusted.
- review: .opencode/state/artifacts/history/core-006/review/2026-04-17T14-32-30-830Z-review.md (review) [superseded] - Review APPROVE for CORE-006: all 5 ACs verified with correct Godot 4.6 GLTFDocument runtime loading, correct variant-assignment timing (variant_name set before add_child), all 4 GLB paths confirmed present, wave_spawner variant dispatch correctly designed, no blocking defects.
- review: .opencode/state/artifacts/history/core-006/review/2026-04-17T14-32-39-916Z-review.md (review) [superseded] - Review REJECT for CORE-006: blocking timing defect — _load_variant_model() called in _ready() but wave_spawner sets variant_name after add_child, causing all enemies to load brown GLB regardless of variant. Plan identifies risk but provides no concrete mitigation. Must resolve deferred loading mechanism before implementation can proceed.
- plan: .opencode/state/artifacts/history/core-006/planning/2026-04-17T14-34-51-091Z-plan.md (planning) [superseded] - Updated plan for CORE-006: Enemy variants with model swapping. Fixes timing defect by using Option A — wave_spawner now sets enemy.variant_name BEFORE add_child(), so _ready() sees correct variant when _load_variant_model() is called. Updated Step 3 with explicit ordering constraint, updated risk register to mark R3 as resolved, added validation step 7 for ordering check, updated AC-4 mapping.
- plan: .opencode/state/artifacts/history/core-006/planning/2026-04-17T14-34-59-082Z-plan.md (planning) - Revised planning artifact for CORE-006: resolves BLOCKER-1 timing defect by switching from auto-_ready() GLB loading to explicit public load_variant_model() method called by wave_spawner after all properties (including variant_name) are set. Updated blockers section, updated risk register marking the prior timing issue as RESOLVED, updated implementation steps to reflect the corrected call order.
- review: .opencode/state/artifacts/history/core-006/review/2026-04-17T14-36-05-642Z-review.md (review) [superseded] - Review APPROVE for CORE-006: Option A timing fix verified correct, all 5 ACs mapped, no remaining blockers. Plan may proceed to implementation.
- review: .opencode/state/artifacts/history/core-006/review/2026-04-17T14-36-38-103Z-review.md (review) [superseded] - Review APPROVE for CORE-006 revised plan: BLOCKER-1 (timing defect) verified RESOLVED. Option A explicit public load_variant_model() method correctly called by wave_spawner after variant_name is set. All 5 ACs covered. All 4 GLB files present. No undeclared blockers.
- implementation: .opencode/state/artifacts/history/core-006/implementation/2026-04-17T14-39-55-596Z-implementation.md (implementation) [superseded] - Implementation complete — all 5 ACs PASS. Created horse_variants.gd singleton with 4-variant dictionary, added ModelContainer/MeshInstance3D to horse_base.tscn, added variant_name + load_variant_model() to horse_base.gd (GLTFDocument runtime GLB loading), updated wave_spawner.gd with variant key and Option A ordering (variant_name set BEFORE add_child, load_variant_model() called AFTER). Godot headless EXIT:0.
- implementation: .opencode/state/artifacts/history/core-006/implementation/2026-04-17T14-41-06-990Z-implementation.md (implementation) - Implementation complete — all 5 ACs PASS. Created horse_variants.gd with 4-variant dictionary, added variant_name + public load_variant_model() to horse_base.gd (Option A timing), updated wave_spawner.gd with variant key in wave_configs and correct spawn order. Godot headless EXIT:0.
- review: .opencode/state/artifacts/history/core-006/review/2026-04-17T14-42-22-727Z-review.md (review) - Review APPROVE for CORE-006: all 5 ACs verified PASS, Option A timing fix confirmed correct, GLTFDocument runtime GLB loading verified, all 4 GLB files present, godot headless EXIT:0.
- qa: .opencode/state/artifacts/history/core-006/qa/2026-04-17T14-42-56-170Z-qa.md (qa) - QA validation PASS — all 5 ACs verified with grep/shell evidence and godot4 headless EXIT:0
- smoke-test: .opencode/state/artifacts/history/core-006/smoke-test/2026-04-17T14-43-47-324Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test passed.
- smoke-test: .opencode/state/artifacts/history/core-006/smoke-test/2026-04-17T21-20-59-700Z-smoke-test.md (smoke-test) - Deterministic smoke test passed.
- backlog-verification: .opencode/state/artifacts/history/core-006/review/2026-04-17T21-21-32-277Z-backlog-verification.md (review) - Backlog verification PASS — all 5 ACs verified with current live executable evidence, no workflow drift, no material proof gaps. Trust intact for process version 7.

## Notes

- Use a Resource or Dictionary for variant data
- Model paths: `res://assets/models/horse-brown.glb`, etc.
- Boss variant should be scaled up 1.3x in addition to model size

