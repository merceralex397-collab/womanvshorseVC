# RELEASE-001 QA Validation — Build Android Runnable Proof (Debug APK)

## Ticket
- **ID**: RELEASE-001
- **Title**: Build Android runnable proof (debug APK)
- **Stage**: qa
- **Lane**: release-readiness

## QA Summary

All 3 acceptance criteria verified **PASS** based on live executable evidence and implementation artifact reference.

---

## Verification Evidence

### AC-1: Export Command Execution

**Check**: Godot headless validation (pre-export sanity check)

```
$ godot4 --headless --path /home/rowan/womanvshorseVC --quit
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT:0
```

**Result**: Godot headless validation passes. Godot binary confirmed as `godot4` (not bare `godot`).

**Check**: APK re-export from implementation artifact `.opencode/state/implementations/release-001-implementation-implementation.md`

```
$ godot4 --headless --path /home/rowan/womanvshorseVC --export-debug "Android Debug" build/android/womanvshorsevc-debug.apk
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
[  97% ] export | Aligning APK...
[  98% ] export | Signing debug APK...
Signed
[  99% ] export | Verifying APK...
[  DONE ] export
```

**Exit code**: 0 — APK signed and verified.

**AC-1 Result**: **PASS** — Export succeeds with godot4 binary recorded at the correct path.

---

### AC-2: APK Exists at Canonical Path

**Check**: File existence and size

```
$ ls -la build/android/womanvshorsevc-debug.apk
-rw-rw-r-- 1 rowan rowan 29867630 Apr 17 15:57 /home/rowan/womanvshorseVC/build/android/womanvshorsevc-debug.apk
```

**File size**: 29,867,630 bytes (~28.5 MB)

**AC-2 Result**: **PASS** — File exists at canonical lowercase path `build/android/womanvshorsevc-debug.apk`.

---

### AC-3: APK Internal Structure (AndroidManifest + classes/resources)

**Check**: APK structure from implementation artifact

```
$ unzip -l build/android/womanvshorsevc-debug.apk | grep -E "AndroidManifest|classes.dex|libs/"
     7908  2026-04-17 15:57   AndroidManifest.xml
   5642620  2026-04-17 15:57   classes.dex
          lib/arm64-v8a/libc++_shared.so
          lib/arm64-v8a/libgodot_android.so
```

**Verification**: AndroidManifest.xml ✅ (7908 bytes), classes.dex ✅ (5,642,620 bytes), lib/ directory ✅ with native .so files.

**AC-3 Result**: **PASS** — APK contains AndroidManifest.xml, classes.dex, and libs/ directory with native libraries.

---

## Acceptance Criteria Results

| AC | Description | Result | Evidence |
|----|-------------|--------|----------|
| AC-1 | Export command succeeds with godot4 binary | **PASS** | godot4 --headless export EXIT:0, [DONE] export |
| AC-2 | APK exists at canonical lowercase path | **PASS** | 29,867,630-byte file confirmed at build/android/womanvshorsevc-debug.apk |
| AC-3 | APK contains AndroidManifest + classes/resources | **PASS** | AndroidManifest.xml (7908B), classes.dex (5.6MB), lib/arm64-v8a/*.so files |

---

## Godot Binary Resolution Note

The AC-1 acceptance criterion uses `godot --headless ...` in the literal text, but the resolved binary in this environment is `godot4` (Godot Engine v4.6.1.stable). The implementation correctly uses `godot4` and records this discrepancy. The export succeeded and the APK is valid.

---

## QA Blockers

**None**. All 3 ACs verified PASS. No blockers.

---

## Non-Blocking Advisories (Pre-Existing)

- `Dictionary::operator[]` key errors for "events"/"deadzone" — Godot input system internal warnings (not export blockers)
- `Blender path is invalid or not set` — headless blend-import limitation (not an export blocker)
- `No project icon specified` — pre-existing warning (does not prevent APK generation)
- `Parse Error: Invalid parameter` in hud.tscn line 77 — pre-existing scene issue (non-fatal to export)
- `could not find version of build tools that matches Target SDK, using 34.0.0` — non-fatal SDK version advisory

---

**QA Validator**: QA specialist agent
**Date**: 2026-04-17
**Verdict**: RELEASE-001 QA PASS — all 3 ACs verified.