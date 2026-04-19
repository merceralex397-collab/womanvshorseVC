# RELEASE-001: Build Android runnable proof (debug APK)

## Summary

Produce and validate the canonical debug APK runnable proof at `build/android/womanvshorsevc-debug.apk` using the repo's resolved Godot binary and Android export pipeline.

## Wave

3

## Lane

release-readiness

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
- finding_source: WFLOW025
- source_ticket_id: None
- source_mode: net_new_scope

## Depends On

FINISH-VALIDATE-001

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] `godot --headless --path . --export-debug "Android Debug" build/android/womanvshorsevc-debug.apk` succeeds or the exact resolved Godot binary equivalent is recorded with the same arguments.
- [ ] The APK exists at `build/android/womanvshorsevc-debug.apk`.
- [ ] `unzip -l build/android/womanvshorsevc-debug.apk` shows Android manifest and classes/resources content.

## Artifacts

- plan: .opencode/state/artifacts/history/release-001/planning/2026-04-17T15-53-41-305Z-plan.md (planning) [superseded] - Planning artifact for RELEASE-001: Build Android runnable proof. Covers path discrepancy analysis (capital VC vs lowercase vc), 6-step implementation, 3-AC mapping, decision tree, risk register, validation plan, and zero blockers. Resolves to re-export targeting lowercase path to satisfy all 3 ACs.
- plan: .opencode/state/artifacts/history/release-001/planning/2026-04-17T15-54-42-008Z-plan.md (planning) - Planning for RELEASE-001: Build Android runnable proof. Covers 5-step re-export plan targeting lowercase APK path, AC mapping to 3 criteria, risk register (3 entries), blockers (none), and validation plan. Decision: re-export required to satisfy AC-2 path requirement.
- review: .opencode/state/artifacts/history/release-001/plan-review/2026-04-17T15-56-09-985Z-review.md (plan_review) - Review APPROVE for RELEASE-001: all 3 ACs mapped to verifiable evidence, path discrepancy resolved, re-export approach sound, zero blockers, no revisions required.
- review: .opencode/state/artifacts/history/release-001/review/2026-04-17T15-56-22-719Z-review.md (review) - Review APPROVE for RELEASE-001: all 3 ACs mapped to verifiable evidence, path discrepancy resolved by re-export, godot4 binary correctly handled, zero blockers, plan may proceed to implementation.
- implementation: .opencode/state/artifacts/history/release-001/implementation/2026-04-17T15-58-23-573Z-implementation.md (implementation) [superseded] - Implementation complete — APK re-exported to lowercase path, all 3 ACs verified PASS with executable evidence.
- implementation: .opencode/state/artifacts/history/release-001/implementation/2026-04-17T15-58-33-434Z-implementation.md (implementation) - Implementation complete — APK re-exported to lowercase path, all 3 ACs verified PASS with live executable evidence.
- qa: .opencode/state/artifacts/history/release-001/qa/2026-04-17T16-00-44-376Z-qa.md (qa) [superseded] - QA validation PASS — all 3 ACs verified with live executable evidence. godot4 export exit 0, APK at canonical lowercase path (29,867,630 bytes), APK structure confirmed via export log (AndroidManifest.xml, 4×classes.dex, lib/arm64-v8a/*.so, resources.arsc).
- qa: .opencode/state/artifacts/history/release-001/qa/2026-04-17T16-01-03-652Z-qa.md (qa) - QA validation PASS — all 3 ACs verified via executable evidence: godot4 export EXIT:0, APK at canonical path (29,867,630 bytes), APK structure confirmed (AndroidManifest.xml, classes.dex, lib/arm64-v8a/*.so files).
- smoke-test: .opencode/state/artifacts/history/release-001/smoke-test/2026-04-17T16-01-07-298Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/release-001/smoke-test/2026-04-17T16-01-37-840Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/release-001/smoke-test/2026-04-17T16-01-44-221Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test failed.
- smoke-test: .opencode/state/artifacts/history/release-001/smoke-test/2026-04-17T16-02-03-684Z-smoke-test.md (smoke-test) [superseded] - Deterministic smoke test passed.
- smoke-test: .opencode/state/artifacts/history/release-001/smoke-test/2026-04-17T21-26-39-153Z-smoke-test.md (smoke-test) - Deterministic smoke test passed.
- backlog-verification: .opencode/state/artifacts/history/release-001/review/2026-04-17T21-27-14-913Z-backlog-verification.md (review) - Backlog verification PASS — all 3 ACs verified with live smoke-test evidence (godot4 EXIT:0, APK 29,867,630 bytes at lowercase path, unzip EXIT:0 with manifest+dex+libs confirmed). No workflow drift. No material proof gaps. Trust restoration recommended for process version 7.
- reverification: .opencode/state/artifacts/history/release-001/review/2026-04-17T21-27-24-733Z-reverification.md (review) - Trust restored using RELEASE-001.

## Notes

- Android SDK and export templates must be installed
- Keystore for debug signing is auto-generated by Godot
- If export fails, check for missing resources or unsupported features

