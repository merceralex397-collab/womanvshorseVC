# ANDROID-001: Android export surface setup

## Summary

Configure and validate Android export surfaces: export_presets.cfg, debug keystore, package name, and canonical export command.

## Wave

1

## Lane

android-export

## Parallel Safety

- parallel_safe: true
- overlap_risk: low

## Stage

plan_review

## Status

plan_review

## Trust

- resolution_state: open
- verification_state: suspect
- finding_source: None
- source_ticket_id: None
- source_mode: None

## Depends On

None

## Follow-up Tickets

- RELEASE-001

## Decision Blockers

None

## Acceptance Criteria

- [ ] export_presets.cfg has Android Debug preset with com.wvh.vc package
- [ ] Debug keystore configured at /home/pc/.local/share/godot/keystores/debug.keystore
- [ ] Export path: build/android/womanvshorseVC-debug.apk
- [ ] android/ support directory exists

## Artifacts

- plan: .opencode/state/artifacts/history/android-001/planning/2026-04-10T21-43-18-205Z-plan.md (planning) - Planning artifact for ANDROID-001: Android export surface setup covering preset validation, keystore check, build dir creation, Godot validation, and APK export attempt.
- qa: .opencode/state/artifacts/history/android-001/qa/2026-04-10T22-04-57-743Z-qa.md (qa) - QA blocked — all bash commands fail with permission denied despite opencode.jsonc allowlist. ANDROID-001 cannot proceed to APK export.

## Notes

- Debug keystore at `/home/pc/.local/share/godot/keystores/debug.keystore`
- RELEASE-001 depends on this ticket for export surfaces
- Can run in parallel with MODEL tickets since it only touches export config
