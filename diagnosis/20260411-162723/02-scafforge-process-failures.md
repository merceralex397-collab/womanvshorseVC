# Scafforge Process Failures

## Scope

- Maps each validated finding back to the Scafforge-owned workflow surface that allowed it through.

## Failure Map

### EXEC-GODOT-004

- linked_report_1_finding: EXEC-GODOT-004
- implicated_surface: generated repo implementation and validation surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Godot headless validation fails.

### EXEC-GODOT-005a

- linked_report_1_finding: EXEC-GODOT-005a
- implicated_surface: generated repo implementation and validation surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Android-targeted Godot repo is missing export surfaces or debug APK runnable proof.

### EXEC-REMED-001

- linked_report_1_finding: EXEC-REMED-001
- implicated_surface: repo-scaffold-factory managed template surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Remediation review artifact does not contain runnable command evidence.

### EXEC-REMED-001

- linked_report_1_finding: EXEC-REMED-001
- implicated_surface: repo-scaffold-factory managed template surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Remediation review artifact does not contain runnable command evidence.

### WFLOW020

- linked_report_1_finding: WFLOW020
- implicated_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- ownership_class: managed workflow contract surface
- workflow_failure: Open-parent ticket decomposition is missing or routed through non-canonical source modes.

## Ownership Classification

### EXEC-GODOT-004

- ownership_class: generated repo execution surface
- affected_surface: generated repo implementation and validation surfaces

### EXEC-GODOT-005a

- ownership_class: generated repo execution surface
- affected_surface: generated repo implementation and validation surfaces

### EXEC-REMED-001

- ownership_class: generated repo execution surface
- affected_surface: repo-scaffold-factory managed template surfaces

### EXEC-REMED-001

- ownership_class: generated repo execution surface
- affected_surface: repo-scaffold-factory managed template surfaces

### WFLOW020

- ownership_class: managed workflow contract surface
- affected_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces

## Root Cause Analysis

### EXEC-GODOT-004

- root_cause: The project cannot complete a deterministic headless Godot load pass on the current host, indicating broken project configuration or scripts.
- safer_target_pattern: Run a deterministic `godot --headless --path . --quit` validation during audit and keep the repo blocked until it succeeds or returns an explicit environment blocker instead.
- how_the_workflow_allowed_it: Godot headless validation fails.

### EXEC-GODOT-005a

- root_cause: The repo has started or closed Android release work but is still missing the repo-managed export preset, android/ support surfaces, or the canonical debug APK. Runnable proof requires export_presets.cfg, non-placeholder android/ surfaces, and a debug APK at the canonical build path.
- safer_target_pattern: Emit export_presets.cfg and android/ surfaces at scaffold time. Block RELEASE-001 closeout until debug APK runnable proof exists at the canonical path.
- how_the_workflow_allowed_it: Android-targeted Godot repo is missing export surfaces or debug APK runnable proof.

### EXEC-REMED-001

- root_cause: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- safer_target_pattern: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.
- how_the_workflow_allowed_it: Remediation review artifact does not contain runnable command evidence.

### EXEC-REMED-001

- root_cause: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- safer_target_pattern: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.
- how_the_workflow_allowed_it: Remediation review artifact does not contain runnable command evidence.

### WFLOW020

- root_cause: The workflow lacks a first-class split route for child tickets created from an open parent, or it still renders split parents as blocked, so agents encode decomposition through remediation semantics and the parent/child graph drifts.
- safer_target_pattern: Support `ticket_create(source_mode=split_scope)` for open-parent decomposition, keep the parent open and non-foreground, and keep open-parent child tickets out of `net_new_scope` and `post_completion_issue` routing.
- how_the_workflow_allowed_it: Open-parent ticket decomposition is missing or routed through non-canonical source modes.

