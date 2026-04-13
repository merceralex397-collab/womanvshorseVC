# Smoke Test

## Ticket

- MODEL-001

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `ls -la assets/models/woman-warrior.glb`
- exit_code: 0
- duration_ms: 7
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
-rw-r--r-- 1 pc pc 14012 Apr 10 00:58 assets/models/woman-warrior.glb
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 2. command override 2

- reason: Explicit smoke-test command override supplied by the caller.
- command: `grep woman-warrior assets/PROVENANCE.md`
- exit_code: 0
- duration_ms: 2
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
| assets/models/woman-warrior.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-10 |
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 3. command override 3

- reason: Explicit smoke-test command override supplied by the caller.
- command: `ls -la assets/models/`
- exit_code: 0
- duration_ms: 2
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
total 24
drwxr-xr-x 2 pc pc  4096 Apr 10 00:58 .
drwxr-xr-x 5 pc pc  4096 Apr  9 22:51 ..
-rw-r--r-- 1 pc pc 14012 Apr 10 00:58 woman-warrior.glb
~~~~

#### stderr

~~~~text
<no output>
~~~~
