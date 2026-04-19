# Initial Codebase Review

## Scope

- subject repo: /home/rowan/womanvshorseVC
- diagnosis timestamp: 2026-04-16T15:32:03Z
- audit scope: managed workflow, restart, ticket, prompt, and execution surfaces
- verification scope: current repo state only

## Result State

- result_state: validated failures found
- finding_count: 8
- errors: 7
- warnings: 1

## Validated Findings

### Workflow Findings

### BOOT003

- finding_id: BOOT003
- summary: The generated bootstrap freshness contract cannot detect host drift for this repo.
- severity: error
- evidence_grade: repo-state validation
- affected_files_or_surfaces: .opencode/state/workflow-state.json, project.godot, export_presets.cfg, opencode.jsonc
- observed_or_reproduced: The recorded bootstrap fingerprint is the empty-hash sentinel even though the repo exposes meaningful bootstrap surfaces. That means the generated workflow was hashing an incomplete input set and can leave bootstrap status stale after moving machines or fixing host prerequisites.
- evidence:
  - .opencode/state/workflow-state.json records bootstrap.environment_fingerprint = e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855.
  - The recorded fingerprint is the empty-hash sentinel, which means bootstrap freshness was computed from no meaningful inputs.
  - Latest bootstrap proof artifact: .opencode/state/artifacts/history/model-001/bootstrap/2026-04-09T22-20-16-559Z-environment-bootstrap.md.
  - Repo surface present despite empty bootstrap fingerprint: project.godot
  - Repo surface present despite empty bootstrap fingerprint: export_presets.cfg
  - Repo surface present despite empty bootstrap fingerprint: opencode.jsonc
  - Repo surface present despite empty bootstrap fingerprint: .opencode/meta/bootstrap-provenance.json
- remaining_verification_gap: None recorded beyond the validated finding scope.

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

### FINISH004

- finding_id: FINISH004
- summary: Interactive consumer-facing repo still relies on a weak generic finish bar instead of explicit interaction-proof requirements.
- severity: error
- evidence_grade: repo-state validation
- affected_files_or_surfaces: docs/spec/CANONICAL-BRIEF.md, tickets/manifest.json
- observed_or_reproduced: Older Scafforge-generated finish contracts and finish-validation tickets could prove only that a build exists, not that the shipped interaction loop and visible user-facing state were actually demonstrated. That leaves low-quality interactive products able to look complete through generic prose.
- evidence:
  - tickets/manifest.json has FINISH-VALIDATE-001, but its acceptance criteria do not require explicit gameplay proof for loop, progression, end-state, and player-facing state reporting.
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

### SKILL002

- finding_id: SKILL002
- summary: The repo requires Blender-MCP for its asset route but is missing mandatory Blender operating surfaces.
- severity: warning
- evidence_grade: repo-state validation
- affected_files_or_surfaces: .opencode/agents/blender-asset-creator.md
- observed_or_reproduced: The managed repo metadata requires Blender work, but the repo-local agent and skill pack did not fully materialize the mandatory Blender contract surfaces.
- evidence:
  - Missing required Blender route agent: .opencode/agents/blender-asset-creator.md
- remaining_verification_gap: None recorded beyond the validated finding scope.

## Code Quality Findings

### EXEC-BLENDER-001

- finding_id: EXEC-BLENDER-001
- summary: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: .opencode/meta/asset-pipeline-bootstrap.json, assets/pipeline.json, .blender-mcp/audit/audit_20260409.jsonl, .blender-mcp/audit/audit_20260410.jsonl, .blender-mcp/audit/audit_20260411.jsonl
- observed_or_reproduced: The repo routes assets through blender-agent, but the audit log shows mutating jobs started with null `input_blend` or `output_blend`. Any later conclusion that the Blender bridge itself is broken is untrustworthy until the same step is retried with an explicit saved-blend chain.
- evidence:
  - mutating_job_count = 172
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
- affected_files_or_surfaces: tickets/manifest.json, .opencode/state/reviews/remed-001-review-ticket-reconciliation.md
- observed_or_reproduced: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- evidence:
  - ticket REMED-001 carries finding_source `EXEC-GODOT-004`
  - review artifact: .opencode/state/reviews/remed-001-review-ticket-reconciliation.md
  - missing exact command record
  - missing raw command output evidence
  - missing explicit post-fix PASS/FAIL result

### EXEC-REMED-001

- finding_id: EXEC-REMED-001
- summary: Remediation review artifact does not contain runnable command evidence.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: tickets/manifest.json, .opencode/state/reviews/remed-003-review-ticket-reconciliation.md
- observed_or_reproduced: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- evidence:
  - ticket REMED-003 carries finding_source `EXEC-REMED-001`
  - review artifact: .opencode/state/reviews/remed-003-review-ticket-reconciliation.md
  - missing exact command record
  - missing raw command output evidence
  - missing explicit post-fix PASS/FAIL result

## Verification Gaps

- The diagnosis pack validates the concrete failures above. It does not claim broader runtime-path coverage than the current audit and supporting evidence actually exercised.

