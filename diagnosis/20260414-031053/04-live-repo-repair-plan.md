# Live Repo Repair Plan

## Preconditions

- Repo: /home/rowan/womanvshorseVC
- Audit stayed non-mutating. No repo or product-code edits were made by this diagnosis run.

## Triage Order

- package_first_count: 0
- subject_repo_follow_up_count: 5
- host_or_manual_prerequisite_count: 0

## Package Changes Required First

- None recorded.

## Post-Update Repair Actions

- Route 2 workflow-layer finding(s) into `scafforge-repair` for deterministic managed-surface refresh.

### REMED-009

- linked_report_id: FINISH003
- action_type: safe Scafforge package change
- should_scafforge_repair_run: yes
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: Seed FINISH-VALIDATE-001 for consumer-facing repos whenever the Product Finish Contract records finish_acceptance_signals, and require RELEASE-001 to depend on that finish-validation lane before closeout.

### REMED-010

- linked_report_id: WFLOW026
- action_type: safe Scafforge package change
- should_scafforge_repair_run: yes
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: Keep one shared artifact verdict extractor that accepts the real artifact family in use: plain and markdown-emphasized verdict labels, compact `QA/Review + verdict` headings, and `Overall: PASS/FAIL` labels. Route ticket_lookup and ticket_update through that shared parser instead of treating explicit review or QA verdicts as unclear.

## Ticket Follow-Up

### REMED-006

- linked_report_id: EXEC-GODOT-004
- action_type: generated-repo remediation ticket/process repair
- should_scafforge_repair_run: only after managed workflow repair converges
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: Run a deterministic `godot --headless --path . --quit` validation during audit and keep the repo blocked until it succeeds or returns an explicit environment blocker instead.
- assignee: implementer
- suggested_fix_approach: Run a deterministic `godot --headless --path . --quit` validation during audit and keep the repo blocked until it succeeds or returns an explicit environment blocker instead.

### REMED-007

- linked_report_id: EXEC-GODOT-005a
- action_type: generated-repo remediation ticket/process repair
- should_scafforge_repair_run: only after managed workflow repair converges
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: Emit export_presets.cfg and android/ surfaces at scaffold time. Block RELEASE-001 closeout until debug APK runnable proof exists at the canonical path.
- assignee: implementer
- suggested_fix_approach: Emit export_presets.cfg and android/ surfaces at scaffold time. Block RELEASE-001 closeout until debug APK runnable proof exists at the canonical path.

### REMED-003

- linked_report_id: EXEC-REMED-001
- action_type: generated-repo remediation ticket/process repair
- should_scafforge_repair_run: only after managed workflow repair converges
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.
- assignee: implementer
- suggested_fix_approach: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.

### REMED-004

- linked_report_id: EXEC-REMED-001
- action_type: generated-repo remediation ticket/process repair
- should_scafforge_repair_run: only after managed workflow repair converges
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.
- assignee: implementer
- suggested_fix_approach: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.

### REMED-008

- linked_report_id: EXEC-REMED-001
- action_type: generated-repo remediation ticket/process repair
- should_scafforge_repair_run: only after managed workflow repair converges
- carry_diagnosis_pack_into_scafforge_first: no
- target_repo: subject repo
- summary: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.
- assignee: implementer
- suggested_fix_approach: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.

## Reverification Plan

- After package-side fixes land, run one fresh audit on the subject repo before applying another repair cycle.
- After managed repair, rerun the public repair verifier and confirm restart surfaces, ticket routing, and any historical trust restoration paths match the current canonical state.
- Do not treat restart prose alone as proof; the canonical manifest and workflow state remain the source of truth.

