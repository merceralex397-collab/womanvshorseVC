# Scafforge Process Failures

## Scope

- Maps each validated finding back to the Scafforge-owned workflow surface that allowed it through.

## Failure Map

### EXEC-BLENDER-001

- linked_report_1_finding: EXEC-BLENDER-001
- implicated_surface: generated repo implementation and validation surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

### CONFIG012

- linked_report_1_finding: CONFIG012
- implicated_surface: scafforge-audit diagnosis contract
- ownership_class: managed workflow contract surface
- workflow_failure: blender_agent is disabled even though the current asset route requires Blender-MCP.

### SKILL003

- linked_report_1_finding: SKILL003
- implicated_surface: project-skill-bootstrap and agent-prompt-engineering surfaces
- ownership_class: project skill or prompt surface
- workflow_failure: The repo requires Blender-MCP for its asset route but is missing mandatory Blender operating surfaces.

## Ownership Classification

### EXEC-BLENDER-001

- ownership_class: generated repo execution surface
- affected_surface: generated repo implementation and validation surfaces

### CONFIG012

- ownership_class: managed workflow contract surface
- affected_surface: scafforge-audit diagnosis contract

### SKILL003

- ownership_class: project skill or prompt surface
- affected_surface: project-skill-bootstrap and agent-prompt-engineering surfaces

## Root Cause Analysis

### EXEC-BLENDER-001

- root_cause: The repo routes assets through blender-agent, but the audit log shows mutating jobs started with null `input_blend` or `output_blend`. Any later conclusion that the Blender bridge itself is broken is untrustworthy until the same step is retried with an explicit saved-blend chain.
- safer_target_pattern: Before escalating a Blender-MCP defect, prove one correct chain: `project_initialize(output_blend=...)`, then a mutating follow-up that reuses the returned `persistence.saved_blend` as `input_blend`, and verify `.blender-mcp/audit/*.jsonl` records non-null `input_blend` / `output_blend` on the matching `job_start`.
- how_the_workflow_allowed_it: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

### CONFIG012

- root_cause: The generated OpenCode configuration did not stay aligned with the repo's canonical asset route metadata.
- safer_target_pattern: Enable blender_agent only when the inferred asset route requires Blender-MCP and the host exposes the required Blender MCP paths.
- how_the_workflow_allowed_it: blender_agent is disabled even though the current asset route requires Blender-MCP.

### SKILL003

- root_cause: The managed repo metadata requires Blender work, but the repo-local agent and skill pack did not fully materialize the mandatory Blender contract surfaces.
- safer_target_pattern: When asset-pipeline metadata requires Blender-MCP, keep `asset-description`, `blender-mcp-workflow`, and a dedicated `blender-asset-creator` in sync with the managed `blender_agent` MCP entry and the repo's asset/audit paths.
- how_the_workflow_allowed_it: The repo requires Blender-MCP for its asset route but is missing mandatory Blender operating surfaces.

