# Review Artifact — RELEASE-001

## Ticket
- **ID:** RELEASE-001
- **Title:** Build Android runnable proof (debug APK)
- **Stage:** review (plan_review)
- **Review date:** 2026-04-17

---

## Verdict: **APPROVE**

---

## Review Checklist

### 1. Path discrepancy correctly identified
**PASS.** Section 1 explicitly states ANDROID-001 produced the APK at `build/android/womanvshorseVC-debug.apk` (uppercase VC) while RELEASE-001 AC-2 requires `build/android/womanvshorsevc-debug.apk` (all lowercase). Root cause and resolution are unambiguous.

### 2. Clear implementation steps
**PASS.** Five steps provided:
- Step 1: Bootstrap/environment confirmation
- Step 2: Re-export via `godot4 --headless --path . --export-debug "Android Debug" build/android/womanvshorsevc-debug.apk`
- Step 3: APK existence check via `ls -la`
- Step 4: APK contents via `unzip -l | grep`
- Step 5: Godot headless validation via `godot4 --headless --path . --quit`

### 3. All 3 ACs mapped to verifiable evidence
**PASS.** Table in Section 4 maps:
- AC-1 (export succeeds) → Steps 2 + 5, godot4 exit code
- AC-2 (APK exists at lowercase path) → Step 3, `ls -la` confirmation
- AC-3 (unzip shows manifest + dex + libs) → Step 4, grep output

Each AC has a specific evidence source and a mapped step.

### 4. Blockers identified
**PASS.** Section 7 states "None" and provides rationale: godot4 resolved (ANDROID-001), Android SDK env vars present (ANDROID-001), export presets configured (ANDROID-001), bootstrap ready (START-HERE).

### 5. Risk register complete
**PASS.** Three risks identified with likelihood, impact, and mitigation:
- Android SDK missing env vars (Low/High — same env as ANDROID-001 which succeeded)
- Preset path override failure (Low/Medium — godot4 supports explicit output path argument)
- APK size/byte differences (Low/Low — AC-2 only requires existence, not exact match)

### 6. godot4 binary resolution correctly handled
**PASS.** The plan uses `godot4` consistently throughout Steps 2–5 and documents it in Section 2 as the resolved binary. The AC-1 command correctly uses `godot4` rather than the generic `godot` placeholder.

### 7. Re-export is the correct decision
**PASS.** AC-2 explicitly requires the APK at `build/android/womanvshorsevc-debug.apk` (all lowercase). The existing ANDROID-001 APK at `build/android/womanvshorseVC-debug.apk` (uppercase VC) does not satisfy AC-2. Renaming the file would not re-run the Godot export signing pipeline. Re-export is the only correct path to produce a valid APK at the required path and ensure the APK is actually runnable.

---

## Summary

The plan is sound. All three acceptance criteria are correctly mapped to verifiable evidence, the path discrepancy is explicitly identified and resolved by re-export, godot4 is correctly used throughout, and the risk register covers three reasonable scenarios with appropriate mitigations. No blocking defects found.

**The plan may proceed to implementation.**
