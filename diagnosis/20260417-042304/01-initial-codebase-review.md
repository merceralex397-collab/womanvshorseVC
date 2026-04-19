# Initial Codebase Review

## Scope

- subject repo: /home/rowan/womanvshorseVC
- diagnosis timestamp: 2026-04-17T04:23:04Z
- audit scope: managed workflow, restart, ticket, prompt, and execution surfaces
- verification scope: current repo state plus supporting logs

## Result State

- result_state: validated failures found
- finding_count: 4
- errors: 4
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
  - Open finish-lane tickets: VISUAL-001, AUDIO-001, FINISH-VALIDATE-001
- remaining_verification_gap: None recorded beyond the validated finding scope.

### FINISH005

- finding_id: FINISH005
- summary: Gameplay-oriented repo claims completion without a current finish-validation artifact that proves the shipped gameplay loop.
- severity: error
- evidence_grade: repo-state validation
- affected_files_or_surfaces: docs/spec/CANONICAL-BRIEF.md, tickets/manifest.json
- observed_or_reproduced: The repo can still look complete from restart state alone because the finish-validation lane does not currently publish a durable artifact showing that gameplay proof actually happened.
- evidence:
  - Repo claims completion or ready state.
  - FINISH-VALIDATE-001 has no current artifact proving gameplay-level finish validation.
- remaining_verification_gap: None recorded beyond the validated finding scope.

### SESSION003

- finding_id: SESSION003
- summary: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.
- severity: error
- evidence_grade: transcript-backed and repo-validated
- affected_files_or_surfaces: /home/rowan/Scafforge/reports/agent-runs/wvhvc-opencode-2026-04-17T04-14-07.log
- observed_or_reproduced: Once the lifecycle gate became confusing, the agent started trying unsupported stages, explicit workarounds, or softer 'close it anyway' / dependency-override reasoning instead of resolving the missing proof or contradictory contract.
- evidence:
  - Line 48: - No in-ticket workaround exists without bridge repair or a pipeline script that handles the chaining externally
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
  - mutating_job_count = 203
  - .blender-mcp/audit/audit_20260409.jsonl:4: scene_batch_edit started without output_blend.
  - .blender-mcp/audit/audit_20260409.jsonl:4: scene_batch_edit started with input_blend=null after prior saved blend /home/pc/projects/womanvshorseVC/tmp/woman-warrior-base.blend.
  - .blender-mcp/audit/audit_20260409.jsonl:6: scene_batch_edit started without output_blend.
  - .blender-mcp/audit/audit_20260409.jsonl:6: scene_batch_edit started with input_blend=null after prior saved blend /home/pc/projects/womanvshorseVC/tmp/woman-warrior-base.blend.
  - .blender-mcp/audit/audit_20260409.jsonl:13: scene_batch_edit started without output_blend.
  - .blender-mcp/audit/audit_20260409.jsonl:13: scene_batch_edit started with input_blend=null after prior saved blend /home/pc/projects/womanvshorseVC/tmp/woman-warrior-step1.blend.
  - .blender-mcp/audit/audit_20260409.jsonl:15: scene_batch_edit started without output_blend.

## Verification Gaps

- The diagnosis pack validates the concrete failures above. It does not claim broader runtime-path coverage than the current audit and supporting evidence actually exercised.

## Rejected or Outdated External Claims

- None recorded separately. Supporting logs were incorporated into the validated findings above instead of being left as standalone unverified claims.

