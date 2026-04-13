# Scafforge Prevention Actions

## Package Changes Required

### ACTION-001

- source_finding: EXEC-GODOT-004
- change_target: generated repo implementation and validation surfaces
- why_it_prevents_recurrence: Tighten generated review and QA guidance so runtime validation and test collection proof exist before closure.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family

### ACTION-002

- source_finding: EXEC-GODOT-005a
- change_target: generated repo implementation and validation surfaces
- why_it_prevents_recurrence: Tighten generated review and QA guidance so runtime validation and test collection proof exist before closure.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family

### ACTION-003

- source_finding: EXEC-REMED-001
- change_target: repo-scaffold-factory managed template surfaces
- why_it_prevents_recurrence: Tighten generated review and QA guidance so runtime validation and test collection proof exist before closure.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family

### ACTION-004

- source_finding: WFLOW010
- change_target: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- why_it_prevents_recurrence: Regenerate derived restart surfaces from canonical manifest and workflow state after every workflow mutation so resume guidance never contradicts active bootstrap, ticket, or lease facts.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-005

- source_finding: WFLOW020
- change_target: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- why_it_prevents_recurrence: Add first-class `split_scope` routing for child tickets created from open parents so decomposition does not drift into non-canonical source modes and split parents do not revert to blocked status.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-006

- source_finding: SKILL001
- change_target: project-skill-bootstrap and agent-prompt-engineering surfaces
- why_it_prevents_recurrence: Detect and repair leftover placeholder local skills so generated stack guidance is concrete before implementation continues.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

## Validation and Test Updates

- EXEC-GODOT-004: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family.

- EXEC-GODOT-005a: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family.

- EXEC-REMED-001: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family.

- WFLOW010: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- WFLOW020: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- SKILL001: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

## Documentation or Prompt Updates

- WFLOW010: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

- WFLOW020: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

- SKILL001: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

## Open Decisions

- None recorded.

