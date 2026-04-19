# Scafforge Process Failures

## Scope

- Maps each validated finding back to the Scafforge-owned workflow surface that allowed it through.

## Failure Map

### EXEC-BLENDER-001

- linked_report_1_finding: EXEC-BLENDER-001
- implicated_surface: generated repo implementation and validation surfaces
- ownership_class: generated repo execution surface
- workflow_failure: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

### FINISH002

- linked_report_1_finding: FINISH002
- implicated_surface: scafforge-audit diagnosis contract
- ownership_class: managed workflow contract surface
- workflow_failure: Repo claims ready or finished state, but the finish contract forbids placeholder output and finish-owning tickets are still open.

### FINISH005

- linked_report_1_finding: FINISH005
- implicated_surface: ticket-pack-builder and ticket contract surfaces
- ownership_class: managed workflow contract surface
- workflow_failure: Gameplay-oriented repo claims completion without a current finish-validation artifact that proves the shipped gameplay loop.

### SESSION003

- linked_report_1_finding: SESSION003
- implicated_surface: scafforge-audit transcript chronology and causal diagnosis surfaces
- ownership_class: audit and lifecycle diagnosis surface
- workflow_failure: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.

## Ownership Classification

### SESSION003

- ownership_class: audit and lifecycle diagnosis surface
- affected_surface: scafforge-audit transcript chronology and causal diagnosis surfaces

### EXEC-BLENDER-001

- ownership_class: generated repo execution surface
- affected_surface: generated repo implementation and validation surfaces

### FINISH002

- ownership_class: managed workflow contract surface
- affected_surface: scafforge-audit diagnosis contract

### FINISH005

- ownership_class: managed workflow contract surface
- affected_surface: ticket-pack-builder and ticket contract surfaces

## Root Cause Analysis

### EXEC-BLENDER-001

- root_cause: The repo routes assets through blender-agent, but the audit log shows mutating jobs started with null `input_blend` or `output_blend`. Any later conclusion that the Blender bridge itself is broken is untrustworthy until the same step is retried with an explicit saved-blend chain.
- safer_target_pattern: Before escalating a Blender-MCP defect, prove one correct chain: `project_initialize(output_blend=...)`, then a mutating follow-up that reuses the returned `persistence.saved_blend` as `input_blend`, and verify `.blender-mcp/audit/*.jsonl` records non-null `input_blend` / `output_blend` on the matching `job_start`.
- how_the_workflow_allowed_it: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.

### FINISH002

- root_cause: The restart narrative or workflow state signals completion while the canonical finish contract still requires non-placeholder visuals, audio, or content proof.
- safer_target_pattern: Either close or supersede the open finish tickets with real content proof, or update the restart narrative to stop claiming finished-product ready state until the finish bar is met.
- how_the_workflow_allowed_it: Repo claims ready or finished state, but the finish contract forbids placeholder output and finish-owning tickets are still open.

### FINISH005

- root_cause: The repo can still look complete from restart state alone because the finish-validation lane does not currently publish a durable artifact showing that gameplay proof actually happened.
- safer_target_pattern: Before a gameplay repo claims completion, keep FINISH-VALIDATE-001 current and publish an artifact that records controls/input proof, progression proof, fail-state or end-state proof, and any player-facing state reporting exercised during validation.
- how_the_workflow_allowed_it: Gameplay-oriented repo claims completion without a current finish-validation artifact that proves the shipped gameplay loop.

### SESSION003

- root_cause: Once the lifecycle gate became confusing, the agent started trying unsupported stages, explicit workarounds, or softer 'close it anyway' / dependency-override reasoning instead of resolving the missing proof or contradictory contract.
- safer_target_pattern: Reject unsupported stages and dependency overrides up front, tell the coordinator not to probe alternate transitions or close blocked tickets anyway, and return the contract contradiction as a blocker when the required proof is missing.
- how_the_workflow_allowed_it: The supplied session transcript shows the agent searching for workflow bypasses or soft dependency overrides instead of following the lifecycle contract.

