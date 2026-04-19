# Scafforge Prevention Actions

## Package Changes Required

### ACTION-001

- source_finding: EXEC-BLENDER-001
- change_target: generated repo implementation and validation surfaces
- why_it_prevents_recurrence: Tighten generated review and QA guidance so runtime validation and test collection proof exist before closure.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family

### ACTION-002

- source_finding: CONFIG012
- change_target: scafforge-audit diagnosis contract
- why_it_prevents_recurrence: Refresh managed workflow docs, tools, and validators together so repair replaces drift instead of layering new semantics over old ones.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-003

- source_finding: SKILL001
- change_target: project-skill-bootstrap and agent-prompt-engineering surfaces
- why_it_prevents_recurrence: Detect and repair leftover placeholder local skills so generated stack guidance is concrete before implementation continues.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-004

- source_finding: SKILL003
- change_target: project-skill-bootstrap and agent-prompt-engineering surfaces
- why_it_prevents_recurrence: When asset-pipeline metadata requires Blender-MCP, keep the required Blender skills, dedicated Blender agent, and managed `blender_agent` MCP entry aligned so the repo can actually follow the declared asset route.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

## Validation and Test Updates

- EXEC-BLENDER-001: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family.

- CONFIG012: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- SKILL001: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- SKILL003: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

## Documentation or Prompt Updates

- SKILL001: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

- SKILL003: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

## Open Decisions

- None recorded.

