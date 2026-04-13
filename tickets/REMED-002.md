# REMED-002: Android-targeted Godot repo is missing export surfaces or debug APK runnable proof

## Summary

Remediate EXEC-GODOT-005a by correcting the validated issue and rerunning the relevant quality checks. Affected surfaces: project.godot, export_presets.cfg, android.

## Wave

5

## Lane

remediation

## Parallel Safety

- parallel_safe: false
- overlap_risk: low

## Stage

closeout

## Status

done

## Trust

- resolution_state: done
- verification_state: reverified
- finding_source: EXEC-GODOT-005a
- source_ticket_id: REMED-003
- source_mode: split_scope

## Depends On

None

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] The validated finding `EXEC-GODOT-005a` no longer reproduces.
- [ ] Current quality checks rerun with evidence tied to the fix approach: Emit export_presets.cfg and android/ surfaces at scaffold time. Block RELEASE-001 closeout until debug APK runnable proof exists at the canonical path.

## Artifacts

- plan: .opencode/state/artifacts/history/remed-002/planning/2026-04-10T04-17-56-420Z-plan.md (planning) [superseded] - Planning artifact for REMED-002: covers 8 sections — scope, files/systems, 5-step implementation, validation plan, risks/assumptions, blockers, AC mapping, and process fix confirmation. Primary fix is regenerating the REMED-001 review artifact with direct command evidence per EXEC-REMED-001.
- plan: .opencode/state/artifacts/history/remed-002/planning/2026-04-10T04-22-39-589Z-plan.md (planning) - Revised planning artifact for REMED-002: includes Step 0 lane lease expansion addressing prior review blocker, 5-step implementation to regenerate REMED-001 review with direct command evidence per EXEC-REMED-001.
- implementation: .opencode/state/artifacts/history/remed-002/implementation/2026-04-10T04-28-58-110Z-implementation.md (implementation) - Implementation artifact for REMED-002 with direct command evidence captured. Contains godot --version and godot --headless command outputs.
- review: .opencode/state/artifacts/history/remed-002/review/2026-04-10T04-29-15-168Z-review.md (review) [superseded] - Review artifact containing regenerated REMED-001 review with direct command evidence. Supersedes original review that cited implementation artifact.
- ticket-reconciliation: .opencode/state/artifacts/history/remed-002/review/2026-04-10T04-29-43-404Z-ticket-reconciliation.md (review) - Reconciled REMED-001 against REMED-002.
- review: .opencode/state/artifacts/history/remed-002/review/2026-04-10T04-33-21-943Z-review.md (review) - Review artifact for REMED-002: all five verification checks PASS. EXEC-REMED-001 is resolved. Regenerated review artifact for REMED-001 now contains direct command evidence.
- qa: .opencode/state/artifacts/history/remed-002/qa/2026-04-10T11-14-42-338Z-qa.md (qa) - QA validation passed - both AC-1 (EXEC-REMED-001 no longer reproduces) and AC-2 (review artifact has direct command evidence with PASS/FAIL) verified PASS
- smoke-test: .opencode/state/artifacts/history/remed-002/smoke-test/2026-04-10T11-15-13-772Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-002/smoke-test/2026-04-10T11-15-59-924Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-002/smoke-test/2026-04-10T11-51-53-525Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-002/smoke-test/2026-04-10T11-52-19-080Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-002/smoke-test/2026-04-10T11-52-24-341Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/remed-002/smoke-test/2026-04-10T11-52-42-176Z-smoke-test.md (smoke-test) - Deterministic smoke test passed.
- backlog-verification: .opencode/state/artifacts/history/remed-002/review/2026-04-11T16-10-14-409Z-backlog-verification.md (review) - Backlog verification PASS — REMED-002 verification complete. All stage artifacts verified current, smoke-test PASS, QA PASS, workflow drift none, proof gaps none. Trust intact for process version 7.
- reverification: .opencode/state/artifacts/history/remed-002/review/2026-04-11T16-10-33-254Z-reverification.md (review) - Trust restored using REMED-002.

## Notes

