# Scafforge Process Failures

## Scope

- Maps each validated finding back to the Scafforge-owned workflow surface that allowed it through.

## Failure Map

### EXEC-GODOT-004

- linked_report_1_finding: EXEC-GODOT-004
- implicated_surface: generated repo implementation and validation surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Godot headless validation fails.

### EXEC-REMED-001

- linked_report_1_finding: EXEC-REMED-001
- implicated_surface: repo-scaffold-factory managed template surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Remediation review artifact does not contain runnable command evidence.

### WFLOW012

- linked_report_1_finding: WFLOW012
- implicated_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- ownership_class: managed workflow contract surface
- workflow_failure: The generated lease-ownership contract is split across coordinator and worker surfaces, so agents can disagree about who should claim a ticket and when bootstrap gates apply.

### WFLOW024

- linked_report_1_finding: WFLOW024
- implicated_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- ownership_class: managed workflow contract surface
- workflow_failure: Fail-state routing is still under-specified in generated prompts or workflow skills.

### SKILL002

- linked_report_1_finding: SKILL002
- implicated_surface: project-skill-bootstrap and agent-prompt-engineering surfaces
- ownership_class: project skill or prompt surface
- workflow_failure: The repo-local `ticket-execution` skill is too thin to explain the actual lifecycle contract to weaker models.

## Ownership Classification

### EXEC-GODOT-004

- ownership_class: generated repo execution surface
- affected_surface: generated repo implementation and validation surfaces

### EXEC-REMED-001

- ownership_class: generated repo execution surface
- affected_surface: repo-scaffold-factory managed template surfaces

### WFLOW012

- ownership_class: managed workflow contract surface
- affected_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces

### WFLOW024

- ownership_class: managed workflow contract surface
- affected_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces

### SKILL002

- ownership_class: project skill or prompt surface
- affected_surface: project-skill-bootstrap and agent-prompt-engineering surfaces

## Root Cause Analysis

### EXEC-GODOT-004

- root_cause: The project cannot complete a deterministic headless Godot load pass on the current host, indicating broken project configuration or scripts.
- safer_target_pattern: Run a deterministic `godot --headless --path . --quit` validation during audit and keep the repo blocked until it succeeds or returns an explicit environment blocker instead.
- how_the_workflow_allowed_it: Godot headless validation fails.

### EXEC-REMED-001

- root_cause: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- safer_target_pattern: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.
- how_the_workflow_allowed_it: Remediation review artifact does not contain runnable command evidence.

### WFLOW012

- root_cause: Some workflow docs and prompts still describe worker-owned lease claims while others expect the team leader to coordinate claims. That contradiction is enough to make weaker models thrash around ticket ownership and pre-bootstrap write rules.
- safer_target_pattern: Adopt one lease model everywhere: the team leader owns `ticket_claim` and `ticket_release`, specialists work only inside the already-active ticket lease, and only Wave 0 setup work may claim before bootstrap is ready.
- how_the_workflow_allowed_it: The generated lease-ownership contract is split across coordinator and worker surfaces, so agents can disagree about who should claim a ticket and when bootstrap gates apply.

### WFLOW024

- root_cause: Even if the tool contract knows how to route a FAIL verdict, weaker models still stall or advance incorrectly when the repo-local workflow explainer and coordinator prompt omit the recovery path.
- safer_target_pattern: Document review, QA, smoke-test, and bootstrap failure recovery paths in ticket-execution, and instruct the team leader to follow transition_guidance.recovery_action whenever it is present.
- how_the_workflow_allowed_it: Fail-state routing is still under-specified in generated prompts or workflow skills.

### SKILL002

- root_cause: When the local workflow explainer omits transition guidance, contradiction-stop rules, artifact ownership, or command boundaries, agents fall back to guess-and-check against the tools.
- safer_target_pattern: Keep `ticket-execution` narrowly procedural: route from `ticket_lookup.transition_guidance`, stop after repeated lifecycle contradictions, reserve `smoke_test` as the only PASS producer, and keep slash commands human-only.
- how_the_workflow_allowed_it: The repo-local `ticket-execution` skill is too thin to explain the actual lifecycle contract to weaker models.

