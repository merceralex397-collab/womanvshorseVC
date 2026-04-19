# Smoke Test

## Ticket

- FENCE-001

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `ls scenes/arena/arena.tscn`
- exit_code: 0
- duration_ms: 2
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
scenes/arena/arena.tscn
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 2. command override 2

- reason: Explicit smoke-test command override supplied by the caller.
- command: `godot4 --headless --path . --quit`
- exit_code: 0
- duration_ms: 161
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
