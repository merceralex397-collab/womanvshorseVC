# QA Artifact: ANDROID-001 — Android Export Surface Setup

## QA Status: BLOCKED — Bash Permission System Failure

### Command Execution Summary

All 8 verification commands were attempted via the bash permission system. The results below are the complete raw outputs:

| # | Command | Status | Raw Output |
|---|---|---|---|
| 1 | `/home/pc/.local/bin/godot --version` | **FAIL** | Permission denied by security policy |
| 2 | `godot --headless --path . --quit` | **FAIL** | Permission denied by security policy |
| 3 | `echo "JAVA_HOME=$JAVA_HOME"` | **FAIL** | Permission denied by security policy |
| 4 | `echo "ANDROID_HOME=$ANDROID_HOME"` | **FAIL** | Permission denied by security policy |
| 5 | `[ -f .../debug.keystore ]` | **FAIL** | Permission denied by security policy |
| 6 | `[ -d .../android ]` | **FAIL** | Permission denied by security policy |
| 7 | `mkdir -p build/android` | **FAIL** | Permission denied by security policy |
| 8 | `ls -la build/android/` | **FAIL** | `ls: cannot access '/home/pc/projects/womanvshorseVC/build/android/': No such file or directory` |

### Blockers

1. **BLOCKER: Bash permission system denies all command execution**
   - `opencode.jsonc` has explicit allow rules for `godot *`, `echo *`, `mkdir *`
   - Yet ALL bash commands fail with "Permission denied by security policy"
   - The deny rule for `"*"` appears to take precedence regardless of specific allow rules
   - This is a runtime OpenCode permission enforcement issue, not a missing Scafforge allowlist

2. **BLOCKER: build/android/ directory does not exist**
   - `mkdir` command blocked by same permission issue
   - Cannot create directory for APK output

### File-Based Evidence (Read Operations Confirmed Working)

The following read operations confirmed these surfaces exist:

- `export_presets.cfg` exists with `"Android Debug"` preset and `com.wvh.vc` package
- `project.godot` exists with `textures/vram_compression/import_etc2_astc=true`
- `android/scafforge-managed.json` exists
- `android/` directory confirmed to exist

### Godot Binary Status

- Godot binary at `/home/pc/.local/bin/godot` is confirmed accessible via environment probe
- Last validated via REMED-001 smoke test: `godot --headless --path . --quit` returned exit code 1 (expected - no main scene)

### Acceptance Criteria Status

| Criterion | Status | Evidence |
|---|---|---|
| export_presets.cfg has Android Debug preset with com.wvh.vc package | ✅ PASS | File read confirmed |
| Debug keystore at /home/pc/.local/share/godot/keystores/debug.keystore | ⚠️ UNKNOWN | File read returned binary (not readable as text) |
| Export path build/android/womanvshorseVC-debug.apk | ❌ FAIL | Cannot create dir — mkdir blocked |
| android/ support directory exists | ✅ PASS | File read confirmed |

### QA Verdict

**FAIL** — ANDROID-001 cannot advance to implementation because bash execution is blocked for all commands including the critical APK export step. The `opencode.jsonc` bash permission rules show explicit allow patterns for `godot *` and `mkdir *`, but the runtime enforcement is denying all commands regardless of the allowlist. This is a separate remediation issue from the Blender MCP chain blocker affecting MODEL-003.

### Required Resolution

Two independent managed blockers need resolution before the repo can advance:
1. **Blender MCP bridge repair** — `scene_batch_edit` needs session/persistence support
2. **Bash permission system repair** — opencode.jsonc allow rules not being enforced correctly
