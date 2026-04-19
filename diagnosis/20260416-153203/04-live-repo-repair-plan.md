# Live Repo Repair Plan

## Preconditions

- Repo: /home/rowan/womanvshorseVC
- Audit stayed non-mutating. No repo or product-code edits were made by this diagnosis run.

## Triage Order

- package_first_count: 0
- subject_repo_follow_up_count: 1
- host_or_manual_prerequisite_count: 0

## Package Changes Required First

- None recorded.

## Post-Update Repair Actions

- Route 7 workflow-layer finding(s) into `scafforge-repair` for deterministic managed-surface refresh.

- After deterministic repair, rerun project-local skill regeneration, agent-team follow-up, and prompt hardening before handoff.

### REMED-009

- linked_report_id: BOOT003
- action_type: safe Scafforge package change
- should_scafforge_repair_run: yes
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: Hash stack-sensitive repo surfaces plus host-side prerequisite signals so bootstrap becomes stale when the machine setup changes, then rerun environment_bootstrap after package repair installs the stronger freshness model.

### REMED-011

- linked_report_id: EXEC-REMED-001
- action_type: safe Scafforge package change
- should_scafforge_repair_run: yes
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.

### REMED-012

- linked_report_id: EXEC-REMED-001
- action_type: safe Scafforge package change
- should_scafforge_repair_run: yes
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.

### REMED-013

- linked_report_id: FINISH002
- action_type: safe Scafforge package change
- should_scafforge_repair_run: yes
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: Either close or supersede the open finish tickets with real content proof, or update the restart narrative to stop claiming finished-product ready state until the finish bar is met.

### REMED-014

- linked_report_id: FINISH004
- action_type: safe Scafforge package change
- should_scafforge_repair_run: yes
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: Replace generic machine-generated finish_acceptance_signals with repo-specific interactive proof requirements, and require FINISH-VALIDATE-001 to demand user-observable interaction evidence in addition to load/export proof.

### REMED-015

- linked_report_id: FINISH005
- action_type: safe Scafforge package change
- should_scafforge_repair_run: yes
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: Before a gameplay repo claims completion, keep FINISH-VALIDATE-001 current and publish an artifact that records controls/input proof, progression proof, fail-state or end-state proof, and any player-facing state reporting exercised during validation.

### REMED-016

- linked_report_id: SKILL002
- action_type: safe Scafforge package change
- should_scafforge_repair_run: yes
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: When asset-pipeline metadata requires Blender-MCP, keep `asset-description`, `blender-mcp-workflow`, and a dedicated `blender-asset-creator` in sync with the managed `blender_agent` MCP entry and the repo's asset/audit paths.

## Ticket Follow-Up

### REMED-010

- linked_report_id: EXEC-BLENDER-001
- action_type: generated-repo remediation ticket/process repair
- should_scafforge_repair_run: only after managed workflow repair converges
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: Before escalating a Blender-MCP defect, prove one correct chain: `project_initialize(output_blend=...)`, then a mutating follow-up that reuses the returned `persistence.saved_blend` as `input_blend`, and verify `.blender-mcp/audit/*.jsonl` records non-null `input_blend` / `output_blend` on the matching `job_start`.
- assignee: implementer
- suggested_fix_approach: Before escalating a Blender-MCP defect, prove one correct chain: `project_initialize(output_blend=...)`, then a mutating follow-up that reuses the returned `persistence.saved_blend` as `input_blend`, and verify `.blender-mcp/audit/*.jsonl` records non-null `input_blend` / `output_blend` on the matching `job_start`.

## Reverification Plan

- After package-side fixes land, run one fresh audit on the subject repo before applying another repair cycle.
- After managed repair, rerun the public repair verifier and confirm restart surfaces, ticket routing, and any historical trust restoration paths match the current canonical state.
- Do not treat restart prose alone as proof; the canonical manifest and workflow state remain the source of truth.

