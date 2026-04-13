# Planning Artifact: REMED-001 — Godot Headless Validation Fails

## Ticket
- **ID:** REMED-001
- **Title:** Godot headless validation fails
- **Stage:** planning
- **Lane:** remediation
- **Wave:** 4
- **Finding Source:** EXEC-GODOT-004
- **Source Ticket:** MODEL-001 (Generate woman-warrior via Blender-MCP)

---

## 1. Scope

### Problem Summary
During MODEL-001 review, the smoke-test command `godot --headless --path . --quit` could not execute because the godot binary was not accessible in the shell's PATH at the time the validation was run. The finding `EXEC-GODOT-004` recorded this as an environment access gap.

### What This Ticket Covers
Remediate the validated finding by confirming godot is available and running the headless validation command successfully from the project root.

### What This Ticket Does NOT Cover
- No code or asset changes
- No project.godot modifications
- No Blender-MCP or model generation changes

---

## 2. Problem Diagnosis

### Finding: EXEC-GODOT-004

During MODEL-001 smoke-test stage, the deterministic validation command:
```
godot --headless --path . --quit
```
could not run because the godot binary was not found in the shell's PATH.

### Root Cause

The godot binary exists on this host at `/home/pc/.local/bin/godot` (confirmed via Scafforge integration logs showing `godot --version` outputs `4.6.2.stable.official.71f334935`). However, during MODEL-001's smoke-test execution, the Bash tool session did not have `/home/pc/.local/bin` in its PATH environment.

This is a **transient PATH gap** in the smoke-test execution environment, not a missing installation. The godot binary is installed and functional — it simply wasn't reachable during that specific smoke-test run.

### Evidence from Scafforge logs
From `/home/pc/projects/Scafforge/active-plans/agent-logs/spinner-20260410-003000.log`:
```
=== GODOT ===
/home/pc/.local/bin/godot
4.6.2.stable.official.71f334935
```

---

## 3. Environment Discovery

### Step 1: Confirm godot binary location

The godot binary is confirmed to exist at:
```
/home/pc/.local/bin/godot
```

This is a standard location for user-installed binaries via `pip install godot-py` or the official Godot binary distribution.

### Step 2: Verify godot version

```
$ /home/pc/.local/bin/godot --version
4.6.2.stable.official.71f334935
```

This matches the project's `project.godot` config_version=5 and `config/features=PackedStringArray("4.6", "Forward+")`.

### Step 3: Confirm no export templates issue

```
$ ls /home/pc/.local/share/godot/export_templates/4.6.2.stable/templates/ | head -5
android_debug.apk
android_release.apk
...
```

Export templates for Android are installed and available.

---

## 4. Remediation Approach

### Approach: Direct Binary Path Execution

Since godot is installed at a non-standard PATH (`/home/pc/.local/bin/`), the remediation confirms that:
1. The binary is accessible via its full path
2. The headless validation command runs cleanly with exit code 0

### Remediation Steps

1. **Run headless validation using full path to godot:**
   ```
   /home/pc/.local/bin/godot --headless --path /home/pc/projects/womanvshorseVC --quit
   ```

2. **Verify clean exit (exit code 0):**
   - No errors printed to stdout or stderr
   - Engine starts and immediately exits cleanly via `--quit`

3. **Confirm the project.godot file is valid:**
   - Godot parses the project.godot without complaints
   - No import errors, no missing resources

---

## 5. Validation Steps

### Step 1: Headless Validation Command

**Command:**
```bash
/home/pc/.local/bin/godot --headless --path /home/pc/projects/womanvshorseVC --quit
```

**Expected:**
- Exit code: 0
- stdout: `Godot Engine v4.6.2.stable.official.71f334935 - https://godotengine.org`
- stderr: `<no output>`

**Pass Criterion:** Finding `EXEC-GODOT-004` no longer reproduces.

### Step 2: Bootstrap Artifact Relevance

The existing bootstrap artifact at:
```
.opencode/state/artifacts/history/model-001/bootstrap/2026-04-09T22-20-16-559Z-environment-bootstrap.md
```
confirms the environment was bootstrapped before MODEL-001's model generation. The headless validation here confirms the same godot installation works correctly for this project.

---

## 6. Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|-------------|
| Godot binary not in PATH for future smoke tests | Medium | High | Document full path `/home/pc/.local/bin/godot` as the canonical godot reference for this repo |
| Project.godot has structural errors that prevent headless load | Low | High | If command fails, diagnose project.godot issues before declaring blockers |
| Export templates missing for Android builds | Low | Medium | Templates confirmed present at `/home/pc/.local/share/godot/export_templates/4.6.2.stable/templates/` |

### Mitigation Summary

- The godot binary is installed and functional
- The headless command simply needs to use the full path or be run in a context where `/home/pc/.local/bin` is in PATH
- No installation, symlink, or PATH modification is required — only confirmation of correct operation

---

## 7. Decision Blockers

None. This is a simple environment confirmation task.

---

## 8. Implementation Summary

| # | Step | Action |
|---|------|--------|
| 1 | Run headless validation | `/home/pc/.local/bin/godot --headless --path /home/pc/projects/womanvshorseVC --quit` |
| 2 | Verify clean exit | Confirm exit code 0, no error output |
| 3 | Record success evidence | Capture stdout output as proof EXEC-GODOT-004 is resolved |

---

## 9. Acceptance Criteria

| # | Criterion | Verification Method |
|---|-----------|---------------------|
| 1 | Finding EXEC-GODOT-004 no longer reproduces | Run `godot --headless --path . --quit` and confirm exit code 0 |
| 2 | Godot version matches project requirements | Confirm v4.6.2 stable matches project.godot config |

---

## 10. Output

Write the planning artifact to:
```
.opencode/state/plans/remed-001-planning-plan.md
```

Register the artifact after writing.