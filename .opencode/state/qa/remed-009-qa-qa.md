# REMED-009 QA Validation — Chaining Chain Execution

## Ticket
- **ID**: REMED-009
- **Title**: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract
- **Finding**: EXEC-BLENDER-001
- **Stage**: QA

## QA Checks

### Check 1: scene_batch_edit call with non-null input_blend
**Status: PASS**

**Evidence** (implementation artifact, lines 17-24):
```json
{
  "input_blend": "/home/rowan/womanvshorseVC/tmp/remed-009-test-init.blend",
  "output_blend": "/home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend",
  "operations": [{"action": "create_primitive", "name": "RemedTestCube", "object": "Cube", "primitive": "cube"}],
  "project_root": "/home/rowan/womanvshorseVC"
}
```

**Audit log confirmation** (record 20260417030247-3fbf8bdecb26, audit_20260417.jsonl line 18):
- `input_blend`: `/home/rowan/womanvshorseVC/tmp/remed-009-test-init.blend` (non-null) ✓
- `output_blend`: `/home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend` (non-null) ✓

---

### Check 2: Audit log shows non-null input_blend/output_blend on matching job_start
**Status: PASS**

**Evidence** (audit_20260417.jsonl line 18, job_id `20260417T030247Z-761597ed6a`):
```
event_type: job_start
job_id: 20260417T030247Z-761597ed6a
tool_name: scene_batch_edit
input_blend: /home/rowan/womanvshorseVC/tmp/remed-009-test-init.blend
input_blend_hash: 59b438245b5bc110c5beb559f9dd9c6b0002769ce79ce4cced9ee7f474d39637
output_blend: /home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend
success: true
```

**job_complete record** (audit_20260417.jsonl line 19):
```
output_blend: /home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend
output_blend_hash: 77f1b19afb716fc5f848293304456df8c9b83db957706601bfe32d4140e7e843
success: true
return_code: 0
```

**file_created record** (audit_20260417.jsonl line 20):
```
files_created: ["/home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend"]
```

---

### Check 3: persistence.saved_blend returned as non-null
**Status: PASS**

**Evidence** (implementation artifact, lines 31-42):
```json
{
  "ok": true,
  "job_id": "20260417T030247Z-761597ed6a",
  "persistence": {
    "input_blend": "/home/rowan/womanvshorseVC/tmp/remed-009-test-init.blend",
    "input_loaded": true,
    "output_blend": "/home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend",
    "output_blend_exists": true,
    "saved_blend": "/home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend",
    "persisted_for_next_call": true,
    "chainable": true
  },
  "saved_blend": "/home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend",
  "output_blend": "/home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend",
  "output_blend_exists": true,
  "execution_state": {
    "executed": true,
    "mutated": true,
    "saved": true,
    "chainable": true,
    "next_action": "continue_chain_with_saved_blend"
  }
}
```

`saved_blend`: `/home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend` (non-null) ✓
`persisted_for_next_call`: true ✓
`chainable`: true ✓

---

### Check 4: Both AC-1 and AC-2 mapped to evidence

#### AC-1: "The validated finding EXEC-BLENDER-001 no longer reproduces."
**Status: PASS**
- The audit log `job_start` record for job `20260417T030247Z-761597ed6a` shows non-null `input_blend` and `output_blend` ✓
- `job_complete` confirms success with output blend hash ✓
- The original EXEC-BLENDER-001 finding (null input_blend on all job_start records) is resolved when caller passes explicit blend paths ✓

#### AC-2: "Prove one correct chain with non-null input_blend/output_blend on matching job_start"
**Status: PASS**
- Chain executed successfully:
  1. `project_initialize(output_blend=...)` → created `remed-009-test-init.blend`
  2. `scene_batch_edit(input_blend=..., output_blend=...)` → created `remed-009-test-chain.blend`
  3. Audit log confirms non-null `input_blend` and `output_blend` on `job_start` ✓
- `saved_blend` returned for use in next call's `input_blend` ✓

---

## Raw Audit Log Extraction (job_id 20260417T030247Z-761597ed6a)

```
record_id: 20260417030247-3fbf8bdecb26
timestamp: 2026-04-17T03:02:47.626410+00:00
event_type: job_start
job_id: 20260417T030247Z-761597ed6a
tool_name: scene_batch_edit
input_blend: /home/rowan/womanvshorseVC/tmp/remed-009-test-init.blend
input_blend_hash: 59b438245b5bc110c5beb559f9dd9c6b0002769ce79ce4cced9ee7f474d39637
output_blend: /home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend
success: true

record_id: 20260417030247-7fa74e9a66f2
timestamp: 2026-04-17T03:02:47.980591+00:00
event_type: job_complete
job_id: 20260417T030247Z-761597ed6a
output_blend: /home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend
output_blend_hash: 77f1b19afb716fc5f848293304456df8c9b83db957706601bfe32d4140e7e843
success: true
return_code: 0

record_id: 20260417030247-f0d2bd2777ca
timestamp: 2026-04-17T03:02:47.981164+00:00
event_type: file_created
job_id: 20260417T030247Z-761597ed6a
files_created: ["/home/rowan/womanvshorseVC/tmp/remed-009-test-chain.blend"]
success: true
```

---

## QA Verdict

| Check | Status |
|-------|--------|
| Check 1: scene_batch_edit call with non-null input_blend | **PASS** |
| Check 2: Audit log shows non-null input_blend/output_blend on job_start | **PASS** |
| Check 3: persistence.saved_blend returned as non-null | **PASS** |
| Check 4: AC-1 and AC-2 both mapped to evidence | **PASS** |

**Overall QA: PASS**

- AC-1 (EXEC-BLENDER-001 no longer reproduces): Verified via audit log showing non-null input_blend/output_blend on job_start record
- AC-2 (correct chain with non-null blend params): Verified via tool response showing saved_blend returned and audit log confirming blend file creation

**QA Sign-off**: REMED-009 is approved for QA stage advancement.
