# Smoke Test

## Ticket

- REMED-018

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `grep -c input_blend .blender-mcp/audit/audit_20260417.jsonl`
- exit_code: 0
- duration_ms: 7
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
536
~~~~

#### stderr

~~~~text
<no output>
~~~~
