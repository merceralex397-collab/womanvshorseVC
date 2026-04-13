# Smoke Test

## Ticket

- MODEL-002

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `godot --version`
- exit_code: 0
- duration_ms: 47
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
4.6.2.stable.official.71f334935
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 2. command override 2

- reason: Explicit smoke-test command override supplied by the caller.
- command: `which godot`
- exit_code: 0
- duration_ms: 2
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
/home/pc/.local/bin/godot
~~~~

#### stderr

~~~~text
<no output>
~~~~
