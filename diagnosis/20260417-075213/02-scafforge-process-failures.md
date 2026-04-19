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

### CONFIG012

- linked_report_1_finding: CONFIG012
- implicated_surface: scafforge-audit diagnosis contract
- ownership_class: managed workflow contract surface
- workflow_failure: blender_agent is disabled even though the current asset route requires Blender-MCP.

### SKILL001

- linked_report_1_finding: SKILL001
- implicated_surface: project-skill-bootstrap and agent-prompt-engineering surfaces
- ownership_class: project skill or prompt surface
- workflow_failure: One or more repo-local skills still contain generic placeholder text or stale synthesized guidance instead of current project-specific procedure.

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

### SKILL001

- ownership_class: project skill or prompt surface
- affected_surface: project-skill-bootstrap and agent-prompt-engineering surfaces

## Root Cause Analysis

### EXEC-BLENDER-001

- root_cause: The repo routes assets through blender-agent, but the audit log shows mutating jobs started with null `input_blend` or `output_blend`. Any later conclusion that the Blender bridge itself is broken is untrustworthy until the same step is retried with an explicit saved-blend chain.
- safer_target_pattern: Before escalating a Blender-MCP defect, prove one correct chain: `project_initialize(output_blend=...)`, then a mutating follow-up that reuses the returned `persistence.saved_blend` as `input_blend`, and verify `.blender-mcp/audit/*.jsonl` records non-null `input_blend` / `output_blend` on the matching `job_start`.
- how_the_workflow_allowed_it: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

### SESSION003

- root_cause: Once the lifecycle gate became confusing, the agent started trying unsupported stages, explicit workarounds, or softer 'close it anyway' / dependency-override reasoning instead of resolving the missing proof or contradictory contract.
- safer_target_pattern: Reject unsupported stages and dependency overrides up front, tell the coordinator not to probe alternate transitions or close blocked tickets anyway, and return the contract contradiction as a blocker when the required proof is missing.
- how_the_workflow_allowed_it: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.

### CONFIG012

- root_cause: The generated OpenCode configuration did not stay aligned with the repo's canonical asset route metadata.
- safer_target_pattern: Enable blender_agent only when the inferred asset route requires Blender-MCP and the host exposes the required Blender MCP paths.
- how_the_workflow_allowed_it: blender_agent is disabled even though the current asset route requires Blender-MCP.

### SKILL001

- root_cause: project-skill-bootstrap or later managed-surface repair left repo-local skills in a placeholder or stale state, so agents lose concrete stack, validation, or asset-workflow guidance.
- safer_target_pattern: Populate every required repo-local skill with concrete current rules and validation commands; generated `.opencode/skills/` files must not retain template filler or stale synthesized workflow guidance.
- how_the_workflow_allowed_it: One or more repo-local skills still contain generic placeholder text or stale synthesized guidance instead of current project-specific procedure.

