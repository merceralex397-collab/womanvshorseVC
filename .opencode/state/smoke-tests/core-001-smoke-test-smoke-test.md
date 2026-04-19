# Smoke Test

## Ticket

- CORE-001

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `ls /home/rowan/womanvshorseVC/scripts/attack_system.gd`
- exit_code: 0
- duration_ms: 1
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
/home/rowan/womanvshorseVC/scripts/attack_system.gd
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 2. command override 2

- reason: Explicit smoke-test command override supplied by the caller.
- command: `grep -c collision.mask /home/rowan/womanvshorseVC/scripts/attack_system.gd`
- exit_code: 0
- duration_ms: 1
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
1
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 3. command override 3

- reason: Explicit smoke-test command override supplied by the caller.
- command: `grep -c signal hit /home/rowan/womanvshorseVC/scripts/attack_system.gd`
- exit_code: 0
- duration_ms: 1
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
1
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 4. command override 4

- reason: Explicit smoke-test command override supplied by the caller.
- command: `grep -c hit.emit /home/rowan/womanvshorseVC/scripts/attack_system.gd`
- exit_code: 0
- duration_ms: 1
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
1
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 5. command override 5

- reason: Explicit smoke-test command override supplied by the caller.
- command: `godot4 --headless --path /home/rowan/womanvshorseVC --quit`
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
