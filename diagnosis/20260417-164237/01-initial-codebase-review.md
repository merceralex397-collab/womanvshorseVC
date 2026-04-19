# Initial Codebase Review

## Scope

- subject repo: /home/rowan/womanvshorseVC
- diagnosis timestamp: 2026-04-17T16:42:37Z
- audit scope: managed workflow, restart, ticket, prompt, and execution surfaces
- verification scope: current repo state plus supporting logs

## Result State

- result_state: validated failures found
- finding_count: 5
- errors: 5
- warnings: 0

## Validated Findings

### Workflow Findings

### SESSION003

- finding_id: SESSION003
- summary: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.
- severity: error
- evidence_grade: transcript-backed and repo-validated
- affected_files_or_surfaces: /home/rowan/Scafforge/reports/agent-runs/wvhvc-opencode-2026-04-17T14-00-00.log
- observed_or_reproduced: Once the lifecycle gate became confusing, the agent started trying unsupported stages, explicit workarounds, or softer 'close it anyway' / dependency-override reasoning instead of resolving the missing proof or contradictory contract.
- evidence:
  - Line 606: 4. **RELEASE-001 smoke-test workaround**: The `smoke_test` tool with `command_override` has a quote-parsing issue. If `command_override` is needed, try using a JSON array of simple strings without embedded quotes in the command itself, or use the base acceptance command that the ticket's AC already specifies.
  - Line 739: `wvhvc-blender-asset-creator` is NOT in the allowed subagent list for `task` calls. Attempted workaround via `wvhvc-lane-executor` but that agent lacks Blender tools.
- remaining_verification_gap: None recorded beyond the validated finding scope.

### SESSION006

- finding_id: SESSION006
- summary: The supplied session transcript shows the operator trapped between contradictory workflow rules instead of having one clear legal next move.
- severity: error
- evidence_grade: transcript-backed and repo-validated
- affected_files_or_surfaces: /home/rowan/Scafforge/reports/agent-runs/wvhvc-opencode-2026-04-17T14-00-00.log
- observed_or_reproduced: Multiple workflow surfaces failed at once: lifecycle gates, closeout publication, acceptance scope, or deterministic tool execution disagreed about what could legally happen next. The coordinator then had to infer workarounds instead of following one competent contract path.
- evidence:
  - workflow thrash: Line 22: [91m[1mError: [0mCannot move to review before an implementation artifact exists.
  - bypass search: Line 606: 4. **RELEASE-001 smoke-test workaround**: The `smoke_test` tool with `command_override` has a quote-parsing issue. If `command_override` is needed, try using a JSON array of simple strings without embedded quotes in the command itself, or use the base acceptance command that the ticket's AC already specifies.
- remaining_verification_gap: None recorded beyond the validated finding scope.

## Code Quality Findings

### EXEC-BLENDER-001

- finding_id: EXEC-BLENDER-001
- summary: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: .opencode/meta/asset-pipeline-bootstrap.json, assets/pipeline.json, .blender-mcp/audit/audit_20260409.jsonl, .blender-mcp/audit/audit_20260410.jsonl, .blender-mcp/audit/audit_20260411.jsonl, .blender-mcp/audit/audit_20260417.jsonl
- observed_or_reproduced: The repo routes assets through blender-agent, but the audit log shows mutating jobs started with null `input_blend` or `output_blend`. Any later conclusion that the Blender bridge itself is broken is untrustworthy until the same step is retried with an explicit saved-blend chain.
- evidence:
  - mutating_job_count = 369
  - .blender-mcp/audit/audit_20260409.jsonl:4: scene_batch_edit started without output_blend.
  - .blender-mcp/audit/audit_20260409.jsonl:4: scene_batch_edit started with input_blend=null after prior saved blend /home/pc/projects/womanvshorseVC/tmp/woman-warrior-base.blend.
  - .blender-mcp/audit/audit_20260409.jsonl:6: scene_batch_edit started without output_blend.
  - .blender-mcp/audit/audit_20260409.jsonl:6: scene_batch_edit started with input_blend=null after prior saved blend /home/pc/projects/womanvshorseVC/tmp/woman-warrior-base.blend.
  - .blender-mcp/audit/audit_20260409.jsonl:13: scene_batch_edit started without output_blend.
  - .blender-mcp/audit/audit_20260409.jsonl:13: scene_batch_edit started with input_blend=null after prior saved blend /home/pc/projects/womanvshorseVC/tmp/woman-warrior-step1.blend.
  - .blender-mcp/audit/audit_20260409.jsonl:15: scene_batch_edit started without output_blend.

### EXEC-REMED-001

- finding_id: EXEC-REMED-001
- summary: Remediation review artifact does not contain runnable command evidence.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: tickets/manifest.json, .opencode/state/reviews/remed-010-review-review.md
- observed_or_reproduced: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- evidence:
  - ticket REMED-010 carries finding_source `EXEC-BLENDER-001`
  - review artifact: .opencode/state/reviews/remed-010-review-review.md
  - missing exact command record
  - missing raw command output evidence
  - missing explicit post-fix PASS/FAIL result

### EXEC-REMED-001

- finding_id: EXEC-REMED-001
- summary: Remediation review artifact does not contain runnable command evidence.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: tickets/manifest.json, .opencode/state/reviews/remed-014-review-ticket-reconciliation.md
- observed_or_reproduced: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- evidence:
  - ticket REMED-014 carries finding_source `EXEC-REMED-001`
  - review artifact: .opencode/state/reviews/remed-014-review-ticket-reconciliation.md
  - missing exact command record
  - missing raw command output evidence
  - missing explicit post-fix PASS/FAIL result

## Verification Gaps

- The diagnosis pack validates the concrete failures above. It does not claim broader runtime-path coverage than the current audit and supporting evidence actually exercised.

## Rejected or Outdated External Claims

- None recorded separately. Supporting logs were incorporated into the validated findings above instead of being left as standalone unverified claims.

