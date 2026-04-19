# Planning Artifact — RELEASE-001

## Ticket
- **ID:** RELEASE-001
- **Title:** Build Android runnable proof (debug APK)
- **Stage:** planning
- **Active ticket lease:** RELEASE-001 (release-readiness lane)

---

## 1. Scope

Produce and validate the canonical debug APK runnable proof at `build/android/womanvshorsevc-debug.apk` (all lowercase, per AC-2) using the repo's resolved Godot binary (`godot4`) and Android export pipeline.

**Decision: Re-export required.** ANDROID-001 produced the APK at `build/android/womanvshorseVC-debug.apk` (uppercase VC), but RELEASE-001 AC-2 explicitly requires the lowercase path `build/android/womanvshorsevc-debug.apk`. The export_presets.cfg also records the uppercase path. A targeted re-export targeting the lowercase path is the only way to satisfy AC-2 without mutating the preset file itself.

---

## 2. Files / Systems Affected

| Surface | Current State | Change |
|---|---|---|
| `build/android/womanvshorsevc-debug.apk` | Does not exist | Create via godot4 re-export |
| `export_presets.cfg` | export_path uppercase VC | Unchanged (preset still valid; target path overridden on command line) |
| `godot4` | Resolved binary | Confirmed for command construction |

---

## 3. Implementation Steps

### Step 1 — Bootstrap environment
- Confirm `godot4` is accessible and repo environment is clean
- No bootstrap defect blocking this ticket (bootstrap status: ready per START-HERE)

### Step 2 — Re-export APK targeting lowercase path
- Run: `godot4 --headless --path . --export-debug "Android Debug" build/android/womanvshorsevc-debug.apk`
- This overrides the preset's export_path for this invocation only
- Expected: clean export, no errors

### Step 3 — Verify APK exists
- `ls -la build/android/womanvshorsevc-debug.apk`
- Expected: file exists, size > 0

### Step 4 — Verify unzip contents
- `unzip -l build/android/womanvshorsevc-debug.apk | grep -E "AndroidManifest.xml|classes.dex|\.so"`
- Expected: manifest, dex, and libs entries present

### Step 5 — Godot headless validation
- `godot4 --headless --path . --quit`
- Expected: EXIT 0 (project loads cleanly)

---

## 4. Acceptance Criteria Mapping

| AC | Requirement | Evidence | Step |
|---|---|---|---|
| AC-1 | Export command succeeds with godot4 | godot4 exit code = 0 | Steps 2, 5 |
| AC-2 | APK exists at `build/android/womanvshorsevc-debug.apk` (lowercase) | `ls -la` confirms file at exact path | Step 3 |
| AC-3 | `unzip -l` shows AndroidManifest.xml + classes.dex + libs | grep output from unzip | Step 4 |

---

## 5. Validation Plan

1. Execute re-export command (Step 2)
2. Confirm `ls -la build/android/womanvshorsevc-debug.apk` returns non-zero size
3. Confirm `unzip -l` shows required entries
4. Confirm godot4 headless quit exits 0
5. Record godot4 binary as resolved tool

---

## 6. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Re-export fails due to Android SDK missing env vars | Low | High | ANDROID-001 already succeeded with same env; env is stable |
| Preset path override does not work | Low | Medium | godot4 supports explicit output path as final argument to override preset |
| APK size differs from ANDROID-001 (date/time stamps in APK) | Low | Low | AC-2 only requires existence, not exact byte-for-byte match |

---

## 7. Blockers

**None.** All prerequisites are satisfied:
- `godot4` resolved and confirmed functional (ANDROID-001)
- Android SDK env vars present (ANDROID-001)
- Export presets configured (ANDROID-001)
- Bootstrap: ready (START-HERE)

---

## 8. Dependencies

- `FINISH-VALIDATE-001` — done, trusted (closeout complete)
- No other active blockers
