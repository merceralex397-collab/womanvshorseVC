# Smoke Test

## Ticket

- REMED-009

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `grep -c 20260417T030247Z /home/rowan/womanvshorseVC/.blender-mcp/audit/audit_20260417.jsonl`
- exit_code: 0
- duration_ms: 1
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

### 2. command override 2

- reason: Explicit smoke-test command override supplied by the caller.
- command: `grep -c /tmp/remed-009-test-chain.blend /home/rowan/womanvshorseVC/.blender-mcp/audit/audit_20260417.jsonl`
- exit_code: 0
- duration_ms: 1
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
- command: `python3 -c import json; data=open('/home/rowan/womanvshorseVC/.blender-mcp/audit/audit_20260417.jsonl').readlines(); print([l for l in data if '20260417T030247Z' in l][:1])`
- exit_code: 0
- duration_ms: 18
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
['{"record_id": "20260417030247-3fbf8bdecb26", "timestamp": "2026-04-17T03:02:47.626410+00:00", "event_type": "job_start", "actor_id": null, "client_id": null, "session_id": null, "job_id": "20260417T030247Z-761597ed6a", "execution_layer": "mcp_tool", "tool_name": "scene_batch_edit", "operator_id": null, "provenance": "certified_workflow", "project_root": "/home/rowan/womanvshorseVC", "input_blend": "/home/rowan/womanvshorseVC/tmp/remed-009-test-init.blend", "input_blend_hash": "59b438245b5bc110c5beb559f9dd9c6b0002769ce79ce4cced9ee7f474d39637", "output_blend": "/home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend", "output_blend_hash": null, "checkpoint_before": null, "checkpoint_after": null, "files_created": [], "files_modified": [], "files_deleted": [], "success": true, "return_code": null, "warnings": [], "errors": [], "trust_profile": "unrestricted", "policy_version": "1.0", "human_override": false, "manual_takeover_by": null, "resumed_after_manual": false, "scene_changed_during_manual": null, "duration_ms": null, "payload_summary": {"operations": "list[1]"}, "command_executed": ["/home/rowan/.local/bin/blender", "--factory-startup", "--background", "/home/rowan/womanvshorseVC/tmp/remed-009-test-init.blend", "--python", "/home/rowan/blender-agent/mcp-server/src/blender_mcp_server/bridge_runtime.py", "--", "--job", "/home/rowan/womanvshorseVC/.blender-mcp/jobs/20260417T030247Z-761597ed6a/job.json", "--result", "/home/rowan/womanvshorseVC/.blender-mcp/jobs/20260417T030247Z-761597ed6a/result.json"]}\n']
~~~~

#### stderr

~~~~text
<no output>
~~~~
