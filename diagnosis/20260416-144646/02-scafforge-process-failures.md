# Scafforge Process Failures

## Scope

- Maps each validated finding back to the Scafforge-owned workflow surface that allowed it through.

## Failure Map

### CYCLE002

- linked_report_1_finding: CYCLE002
- implicated_surface: scafforge-audit diagnosis contract
- ownership_class: audit and lifecycle diagnosis surface
- workflow_failure: Repeated diagnosis packs are re-reporting the same repair-routed findings without any intervening package or process-version change.

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

### EXEC-REMED-001

- linked_report_1_finding: EXEC-REMED-001
- implicated_surface: repo-scaffold-factory managed template surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Remediation review artifact does not contain runnable command evidence.

### FINISH002

- linked_report_1_finding: FINISH002
- implicated_surface: scafforge-audit diagnosis contract
- ownership_class: managed workflow contract surface
- workflow_failure: Repo claims ready or finished state, but the finish contract forbids placeholder output and finish-owning tickets are still open.

### SESSION003

- linked_report_1_finding: SESSION003
- implicated_surface: scafforge-audit transcript chronology and causal diagnosis surfaces
- ownership_class: audit and lifecycle diagnosis surface
- workflow_failure: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.

### SKILL002

- linked_report_1_finding: SKILL002
- implicated_surface: project-skill-bootstrap and agent-prompt-engineering surfaces
- ownership_class: project skill or prompt surface
- workflow_failure: The repo requires Blender-MCP for its asset route but is missing mandatory Blender operating surfaces.

## Ownership Classification

### CYCLE002

- ownership_class: audit and lifecycle diagnosis surface
- affected_surface: scafforge-audit diagnosis contract

### SESSION003

- ownership_class: audit and lifecycle diagnosis surface
- affected_surface: scafforge-audit transcript chronology and causal diagnosis surfaces

### EXEC-BLENDER-001

- ownership_class: generated repo execution surface
- affected_surface: generated repo implementation and validation surfaces

### EXEC-REMED-001

- ownership_class: generated repo execution surface
- affected_surface: repo-scaffold-factory managed template surfaces

### EXEC-REMED-001

- ownership_class: generated repo execution surface
- affected_surface: repo-scaffold-factory managed template surfaces

### FINISH002

- ownership_class: managed workflow contract surface
- affected_surface: scafforge-audit diagnosis contract

### SKILL002

- ownership_class: project skill or prompt surface
- affected_surface: project-skill-bootstrap and agent-prompt-engineering surfaces

## Root Cause Analysis

### CYCLE002

- root_cause: Audit kept producing new diagnosis packs even though the repo had no later Scafforge repair or workflow-contract change after the latest diagnosis. That creates audit churn instead of new decision-making evidence.
- safer_target_pattern: Stop rerunning subject-repo audit until Scafforge package work changes the managed workflow contract or process version, then rerun one fresh audit against the updated package.
- how_the_workflow_allowed_it: Repeated diagnosis packs are re-reporting the same repair-routed findings without any intervening package or process-version change.

### EXEC-BLENDER-001

- root_cause: The repo routes assets through blender-agent, but the audit log shows mutating jobs started with null `input_blend` or `output_blend`. Any later conclusion that the Blender bridge itself is broken is untrustworthy until the same step is retried with an explicit saved-blend chain.
- safer_target_pattern: Before escalating a Blender-MCP defect, prove one correct chain: `project_initialize(output_blend=...)`, then a mutating follow-up that reuses the returned `persistence.saved_blend` as `input_blend`, and verify `.blender-mcp/audit/*.jsonl` records non-null `input_blend` / `output_blend` on the matching `job_start`.
- how_the_workflow_allowed_it: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

### EXEC-REMED-001

- root_cause: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- safer_target_pattern: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.
- how_the_workflow_allowed_it: Remediation review artifact does not contain runnable command evidence.

### EXEC-REMED-001

- root_cause: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- safer_target_pattern: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.
- how_the_workflow_allowed_it: Remediation review artifact does not contain runnable command evidence.

### FINISH002

- root_cause: The restart narrative or workflow state signals completion while the canonical finish contract still requires non-placeholder visuals, audio, or content proof.
- safer_target_pattern: Either close or supersede the open finish tickets with real content proof, or update the restart narrative to stop claiming finished-product ready state until the finish bar is met.
- how_the_workflow_allowed_it: Repo claims ready or finished state, but the finish contract forbids placeholder output and finish-owning tickets are still open.

### SESSION003

- root_cause: Once the lifecycle gate became confusing, the agent started trying unsupported stages, explicit workarounds, or softer 'close it anyway' / dependency-override reasoning instead of resolving the missing proof or contradictory contract.
- safer_target_pattern: Reject unsupported stages and dependency overrides up front, tell the coordinator not to probe alternate transitions or close blocked tickets anyway, and return the contract contradiction as a blocker when the required proof is missing.
- how_the_workflow_allowed_it: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.

### SKILL002

- root_cause: The managed repo metadata requires Blender work, but the repo-local agent and skill pack did not fully materialize the mandatory Blender contract surfaces.
- safer_target_pattern: When asset-pipeline metadata requires Blender-MCP, keep `asset-description`, `blender-mcp-workflow`, and a dedicated `blender-asset-creator` in sync with the managed `blender_agent` MCP entry and the repo's asset/audit paths.
- how_the_workflow_allowed_it: The repo requires Blender-MCP for its asset route but is missing mandatory Blender operating surfaces.

