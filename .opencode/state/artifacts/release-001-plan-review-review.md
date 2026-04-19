# Review Artifact — RELEASE-001 Plan Review

## Ticket
- **ID:** RELEASE-001
- **Title:** Build Android runnable proof (debug APK)
- **Stage:** plan_review
- **Reviewer:** wvhvc-plan-review

---

## Verdict: **APPROVE**

The planning artifact for RELEASE-001 is approved. All 3 acceptance criteria are mapped to verifiable evidence, the path discrepancy is correctly diagnosed, the re-export resolution is sound, and no blockers exist to proceeding to implementation.

---

## Critical Review Items — Findings

### 1. Path discrepancy (capital VC vs lowercase vc) — RESOLVED ✅
The plan correctly identifies the core issue:
- ANDROID-001 produced APK at `build/android/womanvshorseVC-debug.apk` (uppercase VC) — confirmed via ANDROID-001 implementation artifact (29,824,304 bytes)
- RELEASE-001 AC-2 requires `build/android/womanvshorsevc-debug.apk` (all lowercase)
- The plan resolves this via `godot4 --headless --path . --export-debug "Android Debug" build/android/womanvshorsevc-debug.apk` — the explicit output path argument overrides the preset's export_path for this invocation only

### 2. Re-export resolution satisfies all 3 ACs — YES ✅
| AC | Requirement | Evidence | Step |
|---|---|---|---|
| AC-1 | Export command succeeds | godot4 exit code = 0 | Steps 2, 5 |
| AC-2 | APK exists at lowercase path | `ls -la` confirms exact path | Step 3 |
| AC-3 | unzip shows manifest + dex + libs | grep output from unzip | Step 4 |

AC-3's grep pattern `AndroidManifest.xml|classes.dex|\.so` correctly covers all three required content types. The plan's evidence chain is complete.

### 3. Implementation approach (5 steps) — SOUND ✅
The 5-step plan is deterministic and well-sequenced:
1. Bootstrap confirm (godot4 accessible, repo clean)
2. Re-export with explicit lowercase output path override
3. Verify APK exists (`ls -la`)
4. Verify APK contents (`unzip -l | grep`)
5. Godot headless validation (`--quit`)

Step 2's command `godot4 --headless --path . --export-debug "Android Debug" build/android/womanvshorsevc-debug.apk` is the canonical Godot 4 way to override the preset's export_path for a single invocation without mutating export_presets.cfg.

### 4. Environment blockers — NONE ✅
ANDROID-001 (done/trusted) provides the relevant evidence:
- godot4 resolved and functional: confirmed by ANDROID-001 smoke-test passing
- Android SDK env vars (JAVA_HOME, ANDROID_HOME): present and stable — ANDROID-001 completed successfully with same environment
- Bootstrap status: **ready** per START-HERE (verified at 2026-04-17T15:31:51.795Z)
- export_presets.cfg: configured and validated by ANDROID-001

The plan's risk register correctly rates "Re-export fails due to Android SDK missing env vars" as **Low** likelihood because ANDROID-001 already exercised the same export pipeline successfully.

### 5. Dependency on FINISH-VALIDATE-001 — CORRECTLY HANDLED ✅
- FINISH-VALIDATE-001: done, trusted, closeout complete
- No circular dependency issue
- RELEASE-001 has no blockers from FINISH-VALIDATE-001

### 6. Blockers to implementation — NONE ✅
The plan correctly lists zero blockers. All prerequisites are satisfied:
- godot4 resolved: ANDROID-001 smoke-test passed
- Android SDK env vars: confirmed present by ANDROID-001
- Export presets: configured and validated
- Bootstrap: ready
- Follow-up dependency: none required

---

## Advisory Notes (non-blocking)

1. **APK timestamp/size variation:** APK files contain build timestamp metadata, so the re-exported APK will differ in file size and exact byte content from ANDROID-001's APK. The plan correctly notes AC-2 only requires existence, not exact byte-for-byte match. This is expected and acceptable.

2. **godot4 binary name:** The plan uses `godot4` throughout. ANDROID-001 evidence shows the actual binary is at `/home/pc/.local/bin/godot`. The implementation step must verify the correct binary path at execution time — this is a routine implementation concern, not a plan defect.

---

## Evidence Cross-Reference

| Evidence | Source | Key Fact |
|---|---|---|
| APK at uppercase path | ANDROID-001 impl. artifact | `build/android/womanvshorseVC-debug.apk`, 29,824,304 bytes |
| godot4 functional | ANDROID-001 smoke-test | Deterministic smoke test PASSED |
| Android SDK present | ANDROID-001 QA | APK structure verified (AndroidManifest.xml + classes.dex + libs) |
| Bootstrap ready | START-HERE | `bootstrap_status: ready` |
| FINISH-VALIDATE-001 done | manifest.json | `stage: closeout, status: done, verification_state: trusted` |

---

## Conclusion

The plan is complete, correct, and ready for implementation. No revisions required. Proceed to `ticket_update` with `approved_plan: true` and advance RELEASE-001 to implementation.
