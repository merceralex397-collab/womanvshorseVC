# Initial Codebase Review

## Scope

- subject repo: /home/rowan/womanvshorseVC
- diagnosis timestamp: 2026-04-17T18:45:25Z
- audit scope: managed workflow, restart, ticket, prompt, and execution surfaces
- verification scope: current repo state plus supporting logs

## Result State

- result_state: validated failures found
- finding_count: 6
- errors: 5
- warnings: 1

## Validated Findings

### Workflow Findings

### FINISH002

- finding_id: FINISH002
- summary: Repo claims ready or finished state, but the finish contract forbids placeholder output and finish-owning tickets are still open.
- severity: error
- evidence_grade: repo-state validation
- affected_files_or_surfaces: docs/spec/CANONICAL-BRIEF.md
- observed_or_reproduced: The restart narrative or workflow state signals completion while the canonical finish contract still requires non-placeholder visuals, audio, or content proof.
- evidence:
  - docs/spec/CANONICAL-BRIEF.md records no_placeholders policy in the finish contract.
  - Open finish-lane tickets: FENCE-001
- remaining_verification_gap: None recorded beyond the validated finding scope.

### WFLOW005

- finding_id: WFLOW005
- summary: Smoke-test proof can still be fabricated through generic artifact tools instead of the owning deterministic workflow tool.
- severity: error
- evidence_grade: repo-state validation
- affected_files_or_surfaces: .opencode/tools/artifact_write.ts, .opencode/tools/artifact_register.ts, .opencode/plugins/stage-gate-enforcer.ts, .opencode/tools/ticket_lookup.ts
- observed_or_reproduced: If generic artifact surfaces can create smoke-test artifacts, a weaker model can bypass executed validation and publish closeout-ready proof that no deterministic tool produced.
- evidence:
  - .opencode/tools/ticket_lookup.ts does not warn that the expected smoke-test result must come from `smoke_test` rather than generic artifact tools.
- remaining_verification_gap: None recorded beyond the validated finding scope.

### SKILL003

- finding_id: SKILL003
- summary: The repo requires Blender-MCP for its asset route but is missing mandatory Blender operating surfaces.
- severity: warning
- evidence_grade: repo-state validation
- affected_files_or_surfaces: .opencode/agents/wvhvc-team-leader.md
- observed_or_reproduced: The managed repo metadata requires Blender work, but the repo-local agent team and skill pack did not fully materialize the mandatory Blender route contract surfaces.
- evidence:
  - .opencode/agents/wvhvc-team-leader.md must deny direct Blender MCP tool ownership to keep implementation on the blender-asset-creator lane: missing blender_agent_project_initialize: deny
  - .opencode/agents/wvhvc-team-leader.md must deny direct Blender MCP tool ownership to keep implementation on the blender-asset-creator lane: missing blender_agent_scene_batch_edit: deny
  - .opencode/agents/wvhvc-team-leader.md must deny direct Blender MCP tool ownership to keep implementation on the blender-asset-creator lane: missing blender_agent_export_asset: deny
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
  - mutating_job_count = 373
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

