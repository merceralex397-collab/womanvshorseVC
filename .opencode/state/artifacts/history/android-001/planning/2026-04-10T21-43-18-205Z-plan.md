# Planning Artifact: ANDROID-001 — Android Export Surface Setup

## 1. Scope and Objective

**Objective**: Configure and validate Android export surfaces — `export_presets.cfg`, debug keystore, package name, and the canonical Godot export command — so the repo is ready for `RELEASE-001`.

**Wave/Lane**: Wave 1, android-export lane  
**Parallel safety**: `parallel_safe: true` — Android export config is independent of game logic and model generation  
**Overlap risk**: `low` — touches only export config files

---

## 2. Files / Surfaces Affected

| File | Purpose |
|---|---|
| `export_presets.cfg` | Android Debug preset already present; validate its settings |
| `android/scafforge-managed.json` | Android support dir already exists |
| `project.godot` | Rendering compression already set; verify |
| Build output dir `build/android/` | Must exist before export |

### Read-Only Inputs
| File | Purpose |
|---|---|
| `docs/spec/CANONICAL-BRIEF.md` | Android target confirmed |
| `docs/process/git-capability.md` | Local git assumed for commits |

---

## 3. Step-by-Step Implementation

### Step 1 — Verify export_presets.cfg
- **Action**: Read `export_presets.cfg` and confirm:
  - Preset name is `"Android Debug"` (exact match)
  - `platform="Android"`
  - `export_path="build/android/womanvshorseVC-debug.apk"` (case-correct)
  - `package/unique_name="com.wvh.vc"`
  - `keystore/debug` points to `/home/pc/.local/share/godot/keystores/debug.keystore`
- **Pass condition**: All fields match expected values

### Step 2 — Verify debug keystore exists
- **Action**: Run `[ -f /home/pc/.local/share/godot/keystores/debug.keystore ] && echo EXISTS || echo MISSING`
- **Pass condition**: Command returns `EXISTS`

### Step 3 — Ensure build output directory
- **Action**: Run `mkdir -p /home/pc/projects/womanvshorseVC/build/android`
- **Pass condition**: Directory exists; no error

### Step 4 — Verify project.godot rendering compression
- **Action**: Read `project.godot` and confirm `[rendering]` section contains `textures/vram_compression/import_etc2_astc=true`
- **Pass condition**: Setting present (required for Android APK export on Linux)

### Step 5 — Probe Godot availability
- **Action**: Run `/home/pc/.local/bin/godot --version`
- **Pass condition**: Version string returned; binary accessible

### Step 6 — Run Godot headless validation
- **Action**: Run `/home/pc/.local/bin/godot --headless --path /home/pc/projects/womanvshorseVC --quit`
- **Pass condition**: Exit code 0 or 1 with no fatal import errors (exit 1 with "no main scene" is expected)

### Step 7 — Attempt Android debug export
- **Action**: Run Godot export command:
  ```
  /home/pc/.local/bin/godot --headless --path /home/pc/projects/womanvshorseVC --export-debug "Android Debug" build/android/womanvshorseVC-debug.apk
  ```
- **Pass condition**: APK file produced at `build/android/womanvshorseVC-debug.apk`; verify with `ls -la`

---

## 4. Acceptance Criteria Mapping

| # | Criterion | Step |
|---|---|---|
| AC-1 | `export_presets.cfg` has Android Debug preset with `com.wvh.vc` package | Step 1 |
| AC-2 | Debug keystore at `/home/pc/.local/share/godot/keystores/debug.keystore` | Step 2 |
| AC-3 | Export path `build/android/womanvshorseVC-debug.apk` | Step 3 + Step 7 |
| AC-4 | `android/` support directory exists | Step 1 (file check) |

---

## 5. Godot Android Export Command (Canonical)

```bash
mkdir -p build/android
/home/pc/.local/bin/godot --headless --path /home/pc/projects/womanvshorseVC --export-debug "Android Debug" build/android/womanvshorseVC-debug.apk
```

Note: Requires `JAVA_HOME` and `ANDROID_HOME` environment variables set. If export fails with a Java/Android SDK error, those env vars are the first diagnosis path.

---

## 6. Risks and Assumptions

| Risk | Likelihood | Mitigation |
|---|---|---|
| Debug keystore missing or revoked | Low | Check via file existence; regenerate if needed via Godot editor settings |
| `JAVA_HOME` not set | Medium | Export requires Java; add `JAVA_HOME` to env before export |
| `ANDROID_HOME` not set | Medium | Android SDK required; check `echo $ANDROID_HOME` |
| Export preset path has wrong case | Low | Explicit check in Step 1 |

**Assumptions**:
- Godot binary at `/home/pc/.local/bin/godot` is functional (validated via REMED-001)
- `ANDROID_HOME` and `JAVA_HOME` are set on the host (required for Android export)
- No scene files are needed for basic export validation — Godot can export with an empty scene

---

## 7. Next Ticket

`ANDROID-001` feeds directly into `RELEASE-001` which requires the APK to exist.
