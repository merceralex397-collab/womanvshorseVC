# Smoke Test

## Ticket

- MODEL-003

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `ls -la assets/models/horse-black.glb`
- exit_code: 0
- duration_ms: 2
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
-rw-rw-r-- 1 rowan rowan 14596 Apr 17 09:07 assets/models/horse-black.glb
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 2. command override 2

- reason: Explicit smoke-test command override supplied by the caller.
- command: `godot4 --headless --path . --quit`
- exit_code: 0
- duration_ms: 174
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 3. command override 3

- reason: Explicit smoke-test command override supplied by the caller.
- command: `grep horse-black assets/PROVENANCE.md`
- exit_code: 0
- duration_ms: 6
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
| assets/models/horse-black.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-17 |
~~~~

#### stderr

~~~~text
<no output>
~~~~
