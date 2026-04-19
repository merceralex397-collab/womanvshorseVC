# Initial Codebase Review

## Scope

- subject repo: /home/rowan/womanvshorseVC
- diagnosis timestamp: 2026-04-18T00:28:31Z
- audit scope: managed workflow, restart, ticket, prompt, and execution surfaces
- verification scope: current repo state plus supporting logs

## Result State

- result_state: validated failures found
- finding_count: 5
- errors: 5
- warnings: 0

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

### SESSION009

- finding_id: SESSION009
- summary: The supplied session transcript shows a Blender-routed implementation ticket delegated to a generic worker that lacks the required Blender asset-creation toolset.
- severity: error
- evidence_grade: transcript-backed and repo-validated
- affected_files_or_surfaces: /home/rowan/Scafforge/reports/agent-runs/wvhvc-opencode-2026-04-17T23-58-59.log, .opencode/tools/ticket_lookup.ts
- observed_or_reproduced: The installed implementation routing still pointed the coordinator at the generic implementer/lane-executor path even though the same transcript identifies `blender-asset-creator` as the correct worker for the Blender-routed ticket.
- evidence:
  - Line 136: [0m⚙ [0mhandoff_publish {"next_action":"Continue MODEL-007 implementation — blender_agent is enabled in opencode.jsonc, but Blender-MCP scene editing tools (scene_batch_edit, mesh_edit_batch, material_pbr_build, quality_validate, export_asset) were not accessible in prior attempts. The blocker may be tool availability rather than config. Before escalating, re-verify tool accessibility in current session and attempt one fresh Blender-MCP chaining chain."}
  - Line 145: **MODEL-007** — Back as active ticket in `implementation`, still blocked. The blocker is Blender-MCP scene editing tools not being accessible in the current toolset despite `blender_agent` being confirmed enabled in `opencode.jsonc`. Bootstrap is ready. The `wvhvc-blender-asset-creator` delegation is the appropriate next step before escalating a bridge defect.
  - Line 145: **MODEL-007** — Back as active ticket in `implementation`, still blocked. The blocker is Blender-MCP scene editing tools not being accessible in the current toolset despite `blender_agent` being confirmed enabled in `opencode.jsonc`. Bootstrap is ready. The `wvhvc-blender-asset-creator` delegation is the appropriate next step before escalating a bridge defect.
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

