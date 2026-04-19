# Smoke Test

## Ticket

- REMED-023

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `bash -c grep -c "input_blend.*remed-009-test-init" .blender-mcp/audit/audit_20260417.jsonl`
- exit_code: 0
- duration_ms: 4
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
4
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 2. command override 2

- reason: Explicit smoke-test command override supplied by the caller.
- command: `bash -c grep -c "output_blend.*remed-009-test-chain" .blender-mcp/audit/audit_20260417.jsonl`
- exit_code: 0
- duration_ms: 2
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
3
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 3. command override 3

- reason: Explicit smoke-test command override supplied by the caller.
- command: `godot4 --headless --path . --quit`
- exit_code: 0
- duration_ms: 159
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
