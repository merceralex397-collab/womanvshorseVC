# Scafforge Process Failures

## Scope

- Maps each validated finding back to the Scafforge-owned workflow surface that allowed it through.

## Failure Map

### EXEC-BLENDER-001

- linked_report_1_finding: EXEC-BLENDER-001
- implicated_surface: generated repo implementation and validation surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

### EXEC-REMED-001

- linked_report_1_finding: EXEC-REMED-001
- implicated_surface: repo-scaffold-factory managed template surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Remediation review artifact does not contain runnable command evidence.

### SESSION003

- linked_report_1_finding: SESSION003
- implicated_surface: scafforge-audit transcript chronology and causal diagnosis surfaces
- ownership_class: audit and lifecycle diagnosis surface
- workflow_failure: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.

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

### EXEC-REMED-001

- ownership_class: generated repo execution surface
- affected_surface: repo-scaffold-factory managed template surfaces

### SKILL001

- ownership_class: project skill or prompt surface
- affected_surface: project-skill-bootstrap and agent-prompt-engineering surfaces

## Root Cause Analysis

### EXEC-BLENDER-001

- root_cause: The repo routes assets through blender-agent, but the audit log shows mutating jobs started with null `input_blend` or `output_blend`. Any later conclusion that the Blender bridge itself is broken is untrustworthy until the same step is retried with an explicit saved-blend chain.
- safer_target_pattern: Before escalating a Blender-MCP defect, prove one correct chain: `project_initialize(output_blend=...)`, then a mutating follow-up that reuses the returned `persistence.saved_blend` as `input_blend`, and verify `.blender-mcp/audit/*.jsonl` records non-null `input_blend` / `output_blend` on the matching `job_start`.
- how_the_workflow_allowed_it: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

### EXEC-REMED-001

- root_cause: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- safer_target_pattern: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.
- how_the_workflow_allowed_it: Remediation review artifact does not contain runnable command evidence.

### SESSION003

- root_cause: Once the lifecycle gate became confusing, the agent started trying unsupported stages, explicit workarounds, or softer 'close it anyway' / dependency-override reasoning instead of resolving the missing proof or contradictory contract.
- safer_target_pattern: Reject unsupported stages and dependency overrides up front, tell the coordinator not to probe alternate transitions or close blocked tickets anyway, and return the contract contradiction as a blocker when the required proof is missing.
- how_the_workflow_allowed_it: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.

### SKILL001

- root_cause: project-skill-bootstrap or later managed-surface repair left repo-local skills in a placeholder or stale state, so agents lose concrete stack, validation, or asset-workflow guidance.
- safer_target_pattern: Populate every required repo-local skill with concrete current rules and validation commands; generated `.opencode/skills/` files must not retain template filler or stale synthesized workflow guidance.
- how_the_workflow_allowed_it: One or more repo-local skills still contain generic placeholder text or stale synthesized guidance instead of current project-specific procedure.

