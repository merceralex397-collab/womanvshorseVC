# Smoke Test

## Ticket

- ANDROID-001

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `godot4 --headless --path . --quit`
- exit_code: 0
- duration_ms: 168
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

### 2. command override 2

- reason: Explicit smoke-test command override supplied by the caller.
- command: `ls -la build/android/womanvshorseVC-debug.apk`
- exit_code: 0
- duration_ms: 2
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
-rw-rw-r-- 1 rowan rowan 29824304 Apr 17 14:02 build/android/womanvshorseVC-debug.apk
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 3. command override 3

- reason: Explicit smoke-test command override supplied by the caller.
- command: `file build/android/womanvshorseVC-debug.apk`
- exit_code: 0
- duration_ms: 22
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
build/android/womanvshorseVC-debug.apk: Android package (APK), with classes.dex
~~~~

#### stderr

~~~~text
<no output>
~~~~
