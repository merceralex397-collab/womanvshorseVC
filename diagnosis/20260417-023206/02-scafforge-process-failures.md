# Scafforge Process Failures

## Scope

- Maps each validated finding back to the Scafforge-owned workflow surface that allowed it through.

## Failure Map

### EXEC-BLENDER-001

- linked_report_1_finding: EXEC-BLENDER-001
- implicated_surface: generated repo implementation and validation surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

### SESSION003

- linked_report_1_finding: SESSION003
- implicated_surface: scafforge-audit transcript chronology and causal diagnosis surfaces
- ownership_class: audit and lifecycle diagnosis surface
- workflow_failure: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.

### WFLOW020

- linked_report_1_finding: WFLOW020
- implicated_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- ownership_class: managed workflow contract surface
- workflow_failure: Open-parent ticket decomposition is missing or routed through non-canonical source modes.

### CONFIG012

- linked_report_1_finding: CONFIG012
- implicated_surface: scafforge-audit diagnosis contract
- ownership_class: managed workflow contract surface
- workflow_failure: blender_agent is disabled even though the current asset route requires Blender-MCP.

## Ownership Classification

### SESSION003

- ownership_class: audit and lifecycle diagnosis surface
- affected_surface: scafforge-audit transcript chronology and causal diagnosis surfaces

### EXEC-BLENDER-001

- ownership_class: generated repo execution surface
- affected_surface: generated repo implementation and validation surfaces

### CONFIG012

- ownership_class: managed workflow contract surface
- affected_surface: scafforge-audit diagnosis contract

### WFLOW020

- ownership_class: managed workflow contract surface
- affected_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces

## Root Cause Analysis

### EXEC-BLENDER-001

- root_cause: The repo routes assets through blender-agent, but the audit log shows mutating jobs started with null `input_blend` or `output_blend`. Any later conclusion that the Blender bridge itself is broken is untrustworthy until the same step is retried with an explicit saved-blend chain.
- safer_target_pattern: Before escalating a Blender-MCP defect, prove one correct chain: `project_initialize(output_blend=...)`, then a mutating follow-up that reuses the returned `persistence.saved_blend` as `input_blend`, and verify `.blender-mcp/audit/*.jsonl` records non-null `input_blend` / `output_blend` on the matching `job_start`.
- how_the_workflow_allowed_it: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

### SESSION003

- root_cause: Once the lifecycle gate became confusing, the agent started trying unsupported stages, explicit workarounds, or softer 'close it anyway' / dependency-override reasoning instead of resolving the missing proof or contradictory contract.
- safer_target_pattern: Reject unsupported stages and dependency overrides up front, tell the coordinator not to probe alternate transitions or close blocked tickets anyway, and return the contract contradiction as a blocker when the required proof is missing.
- how_the_workflow_allowed_it: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.

### WFLOW020

- root_cause: The workflow lacks a first-class split route for child tickets created from an open parent, or it still renders split parents as blocked, so agents encode decomposition through remediation semantics and the parent/child graph drifts.
- safer_target_pattern: Support `ticket_create(source_mode=split_scope)` for open-parent decomposition, keep the parent open and non-foreground, and keep open-parent child tickets out of `net_new_scope` and `post_completion_issue` routing.
- how_the_workflow_allowed_it: Open-parent ticket decomposition is missing or routed through non-canonical source modes.

### CONFIG012

- root_cause: The generated OpenCode configuration did not stay aligned with the repo's canonical asset route metadata.
- safer_target_pattern: Enable blender_agent only when the inferred asset route requires Blender-MCP and the host exposes the required Blender MCP paths.
- how_the_workflow_allowed_it: blender_agent is disabled even though the current asset route requires Blender-MCP.

