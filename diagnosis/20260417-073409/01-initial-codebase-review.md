# Initial Codebase Review

## Scope

- subject repo: /home/rowan/womanvshorseVC
- diagnosis timestamp: 2026-04-17T07:34:09Z
- audit scope: managed workflow, restart, ticket, prompt, and execution surfaces
- verification scope: current repo state only

## Result State

- result_state: validated failures found
- finding_count: 2
- errors: 1
- warnings: 1

## Validated Findings

### Workflow Findings

### CONFIG012

- finding_id: CONFIG012
- summary: blender_agent is disabled even though the current asset route requires Blender-MCP.
- severity: warning
- evidence_grade: repo-state validation
- affected_files_or_surfaces: opencode.jsonc
- observed_or_reproduced: The generated OpenCode configuration did not stay aligned with the repo's canonical asset route metadata.
- evidence:
  - Expected blender route: True
  - blender_agent.enabled = False
  - Expected primary routes: {'characters': 'blender-mcp-generated', 'environments': 'godot-native-authored', 'props': 'blender-mcp-generated', 'ui': 'godot-native-authored', 'audio': 'third-party-open-licensed', 'vfx': 'godot-native-authored'}
- remaining_verification_gap: None recorded beyond the validated finding scope.

## Code Quality Findings

### EXEC-BLENDER-001

- finding_id: EXEC-BLENDER-001
- summary: Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: .opencode/meta/asset-pipeline-bootstrap.json, assets/pipeline.json, .blender-mcp/audit/audit_20260409.jsonl, .blender-mcp/audit/audit_20260410.jsonl, .blender-mcp/audit/audit_20260411.jsonl, .blender-mcp/audit/audit_20260417.jsonl
- observed_or_reproduced: The repo routes assets through blender-agent, but the audit log shows mutating jobs started with null `input_blend` or `output_blend`. Any later conclusion that the Blender bridge itself is broken is untrustworthy until the same step is retried with an explicit saved-blend chain.
- evidence:
  - mutating_job_count = 203
  - .blender-mcp/audit/audit_20260409.jsonl:4: scene_batch_edit started without output_blend.
  - .blender-mcp/audit/audit_20260409.jsonl:4: scene_batch_edit started with input_blend=null after prior saved blend /home/pc/projects/womanvshorseVC/tmp/woman-warrior-base.blend.
  - .blender-mcp/audit/audit_20260409.jsonl:6: scene_batch_edit started without output_blend.
  - .blender-mcp/audit/audit_20260409.jsonl:6: scene_batch_edit started with input_blend=null after prior saved blend /home/pc/projects/womanvshorseVC/tmp/woman-warrior-base.blend.
  - .blender-mcp/audit/audit_20260409.jsonl:13: scene_batch_edit started without output_blend.
  - .blender-mcp/audit/audit_20260409.jsonl:13: scene_batch_edit started with input_blend=null after prior saved blend /home/pc/projects/womanvshorseVC/tmp/woman-warrior-step1.blend.
  - .blender-mcp/audit/audit_20260409.jsonl:15: scene_batch_edit started without output_blend.

## Verification Gaps

- The diagnosis pack validates the concrete failures above. It does not claim broader runtime-path coverage than the current audit and supporting evidence actually exercised.

