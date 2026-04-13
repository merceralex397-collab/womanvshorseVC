# Scafforge Process Failures

## Scope

- Maps each validated finding back to the Scafforge-owned workflow surface that allowed it through.

## Failure Map

### CYCLE002

- linked_report_1_finding: CYCLE002
- implicated_surface: scafforge-audit diagnosis contract
- ownership_class: audit and lifecycle diagnosis surface
- workflow_failure: Repeated diagnosis packs are re-reporting the same repair-routed findings without any intervening package or process-version change.

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

### WFLOW010

- linked_report_1_finding: WFLOW010
- implicated_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- ownership_class: managed workflow contract surface
- workflow_failure: Derived restart surfaces disagree with canonical workflow state, so resume guidance can route work from stale or contradictory facts.

## Ownership Classification

### CYCLE002

- ownership_class: audit and lifecycle diagnosis surface
- affected_surface: scafforge-audit diagnosis contract

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

### WFLOW010

- ownership_class: managed workflow contract surface
- affected_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces

## Root Cause Analysis

### CYCLE002

- root_cause: Audit kept producing new diagnosis packs even though the repo had no later Scafforge repair or workflow-contract change after the latest diagnosis. That creates audit churn instead of new decision-making evidence.
- safer_target_pattern: Stop rerunning subject-repo audit until Scafforge package work changes the managed workflow contract or process version, then rerun one fresh audit against the updated package.
- how_the_workflow_allowed_it: Repeated diagnosis packs are re-reporting the same repair-routed findings without any intervening package or process-version change.

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

### WFLOW010

- root_cause: `START-HERE.md`, `.opencode/state/context-snapshot.md`, and `.opencode/state/latest-handoff.md` are not being regenerated from `tickets/manifest.json`, `.opencode/state/workflow-state.json`, and `.opencode/meta/pivot-state.json` after workflow mutations or managed repair, leaving bootstrap, repair-follow-on, pivot, verification, lane-lease, or active-ticket state stale.
- safer_target_pattern: Regenerate `START-HERE.md`, `.opencode/state/context-snapshot.md`, and `.opencode/state/latest-handoff.md` from canonical manifest, workflow state, and pivot state after every workflow save, compute handoff readiness from bootstrap plus repair-follow-on plus verification state in one shared contract, and fail repair verification if any derived restart surface drifts.
- how_the_workflow_allowed_it: Derived restart surfaces disagree with canonical workflow state, so resume guidance can route work from stale or contradictory facts.

