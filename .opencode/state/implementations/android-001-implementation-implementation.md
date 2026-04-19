# Implementation Artifact: ANDROID-001

**Ticket:** ANDROID-001 — Android export surface setup  
**Lane:** android-export  
**Stage:** implementation  
**Date:** 2026-04-17T14:02:00Z

---

## Execution Summary

All 4 acceptance criteria verified PASS via real command execution and file inspection.

| AC | Description | Status |
|----|-------------|--------|
| AC-1 | `export_presets.cfg` has Android Debug preset with `com.wvh.vc` package | ✅ PASS |
| AC-2 | Debug keystore configured at `/home/rowan/.android/debug.keystore` | ✅ PASS |
| AC-3 | Export path `build/android/womanvshorseVC-debug.apk` | ✅ PASS |
| AC-4 | `android/` support directory exists | ✅ PASS |

---

## Pre-flight Validation

### Step 1 — Godot version probe
```
Command: godot4 --version
Output:
  Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT:0
```

### Step 2 — Godot headless project validation
```
Command: godot4 --headless --path /home/rowan/womanvshorseVC --quit
Output:
  Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT:0
```

---

## File Corrective Edits Applied

Before the export run, two misconfigurations in `export_presets.cfg` were corrected:

### Fix 1 — Package name (AC-1)
```
File: export_presets.cfg
Old: package/unique_name="com.example.womanvshorsevc"
New: package/unique_name="com.wvh.vc"
```

### Fix 2 — Export path case (AC-3)
```
File: export_presets.cfg
Old: export_path="build/android/womanvshorsevc-debug.apk"
New: export_path="build/android/womanvshorseVC-debug.apk"
```

---

## Android Export Execution

### Step 3 — Run Android debug export
```
Command: godot4 --headless --path /home/rowan/womanvshorseVC --export-debug "Android Debug" build/android/womanvshorseVC-debug.apk

Output (key lines):
  Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
  [   0% ] export | Started Exporting for Android (105 steps)
  [  97% ] export | Aligning APK...
  [  98% ] export | Signing debug APK...
  Signing binary using: /home/rowan/horseshooter/android_sdk/build-tools/34.0.0/apksigner sign --verbose --ks <REDACTED> --ks-pass pass:<REDACTED> --ks-key-alias <REDACTED> /home/rowan/womanvshorseVC/build/android/womanvshorseVC-debug.apk
  Signed
  [  99% ] export | Verifying APK...
  [ DONE ] export
EXIT:0
```

Note: Some non-fatal warnings appear during export (missing Blender path for GLTF import, script parse errors in attack_system.gd, missing project icon). These are pre-existing project issues unrelated to the export surface setup. The export itself completed successfully with APK signing.

---

## Acceptance Criteria Evidence

### AC-1 — Package name
```
File: export_presets.cfg, line 39
  package/unique_name="com.wvh.vc"
```
✅ PASS — `com.wvh.vc` confirmed in export_presets.cfg

### AC-2 — Debug keystore
```
File: export_presets.cfg, line 32
  keystore/debug="/home/rowan/.android/debug.keystore"

Filesystem verification:
  $ ls -la /home/rowan/.android/debug.keystore
  -rw-rw-r-- 1 rowan rowan 2666 Apr 14 04:35 /home/rowan/.android/debug.keystore
```
✅ PASS — Keystore path configured and file exists

### AC-3 — Export path
```
File: export_presets.cfg, line 15
  export_path="build/android/womanvshorseVC-debug.apk"

APK verification:
  $ ls -la /home/rowan/womanvshorseVC/build/android/womanvshorseVC-debug.apk
  -rw-rw-r-- 1 rowan rowan 29824304 Apr 17 14:02 /home/rowan/womanvshorseVC/build/android/womanvshorseVC-debug.apk
```
✅ PASS — APK generated at correct path, 29824304 bytes, signed

### AC-4 — android/ directory
```
Filesystem verification:
  $ ls -la /home/rowan/womanvshorseVC/android/
  total 12
  drwxr-xr-x 2 rowan rowan 4096 Apr 14 02:34 .
  -rw-rw-r-- 1 rowan rowan  526 Apr 14 02:34 scafforge-managed.json
```
✅ PASS — `android/` directory exists with Scafforge-managed metadata

---

## APK Contents Verification

```
Command: unzip -l build/android/womanvshorseVC-debug.apk | head -30

Key entries confirmed:
  classes.dex          5642620 bytes
  classes2.dex           340044 bytes
  classes3.dex            40828 bytes
  classes4.dex               828 bytes
  lib/arm64-v8a/libc++_shared.so
  lib/arm64-v8a/libgodot_android.so
  AndroidManifest.xml
  resources.arsc
  res/mipmap-*/icon.png
```
✅ APK is valid Android package with manifest, dex files, native libraries, and resources

---

## Build Verification

After all edits and the export run, the project headless validation still passes:

```
Command: godot4 --headless --path /home/rowan/womanvshorseVC --quit
EXIT:0
```

---

## Blocking Findings

None. All 4 ACs are met with live executable evidence.

---

**Artifact path:** `.opencode/state/implementations/android-001-implementation-implementation.md`  
**Verification:** All 4 ACs PASS via direct file content and command output evidence