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

### WFLOW005

- linked_report_1_finding: WFLOW005
- implicated_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- ownership_class: managed workflow contract surface
- workflow_failure: Smoke-test proof can still be fabricated through generic artifact tools instead of the owning deterministic workflow tool.

### SKILL003

- linked_report_1_finding: SKILL003
- implicated_surface: project-skill-bootstrap and agent-prompt-engineering surfaces
- ownership_class: project skill or prompt surface
- workflow_failure: The repo requires Blender-MCP for its asset route but is missing mandatory Blender operating surfaces.

## Ownership Classification

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

### WFLOW005

- ownership_class: managed workflow contract surface
- affected_surface: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces

### SKILL003

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

### EXEC-REMED-001

- root_cause: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- safer_target_pattern: For remediation tickets with `finding_source`, require the review artifact to record the exact command run, include raw command output, and state the explicit PASS/FAIL result before the review counts as trustworthy closure.
- how_the_workflow_allowed_it: Remediation review artifact does not contain runnable command evidence.

### FINISH002

- root_cause: The restart narrative or workflow state signals completion while the canonical finish contract still requires non-placeholder visuals, audio, or content proof.
- safer_target_pattern: Either close or supersede the open finish tickets with real content proof, or update the restart narrative to stop claiming finished-product ready state until the finish bar is met.
- how_the_workflow_allowed_it: Repo claims ready or finished state, but the finish contract forbids placeholder output and finish-owning tickets are still open.

### WFLOW005

- root_cause: If generic artifact surfaces can create smoke-test artifacts, a weaker model can bypass executed validation and publish closeout-ready proof that no deterministic tool produced.
- safer_target_pattern: Reserve smoke-test artifacts to `smoke_test`, and make the plugin plus transition guidance reject generic PASS-proof fabrication while keeping optional handoff artifacts consistent with docs-lane ownership.
- how_the_workflow_allowed_it: Smoke-test proof can still be fabricated through generic artifact tools instead of the owning deterministic workflow tool.

### SKILL003

- root_cause: The managed repo metadata requires Blender work, but the repo-local agent team and skill pack did not fully materialize the mandatory Blender route contract surfaces.
- safer_target_pattern: When asset-pipeline metadata requires Blender-MCP, keep `asset-description`, `blender-mcp-workflow`, a dedicated `blender-asset-creator`, and the team leader's delegation allowlist in sync with the managed `blender_agent` MCP entry and the repo's asset/audit paths.
- how_the_workflow_allowed_it: The repo requires Blender-MCP for its asset route but is missing mandatory Blender operating surfaces.

