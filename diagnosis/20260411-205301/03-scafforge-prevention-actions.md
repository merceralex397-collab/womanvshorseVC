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

- source_finding: WFLOW012
- change_target: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- why_it_prevents_recurrence: Use one lease-ownership model everywhere: the team leader claims and releases ticket leases, specialists work under the active lease, and only Wave 0 setup work may claim before bootstrap is ready.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-005

- source_finding: WFLOW019
- change_target: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- why_it_prevents_recurrence: Add a canonical ticket-graph reconciliation path so stale source/follow-up linkage and contradictory dependencies are repaired atomically instead of by manual manifest edits.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-006

- source_finding: WFLOW024
- change_target: repo-scaffold-factory generated workflow, handoff, and tool contract surfaces
- why_it_prevents_recurrence: Give historical reconciliation one legal evidence-backed path so superseded invalidated tickets can be repaired without depending on impossible direct-artifact or closeout assumptions.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-007

- source_finding: SKILL002
- change_target: project-skill-bootstrap and agent-prompt-engineering surfaces
- why_it_prevents_recurrence: Make the generated `ticket-execution` skill the canonical lifecycle explainer so weaker models do not have to reverse-engineer the state machine from tool errors.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

## Validation and Test Updates

- EXEC-GODOT-004: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family.

- EXEC-GODOT-005a: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family.

- EXEC-REMED-001: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family.

- WFLOW012: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- WFLOW019: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- WFLOW024: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- SKILL002: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

## Documentation or Prompt Updates

- WFLOW012: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

- WFLOW019: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

- WFLOW024: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

- SKILL002: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

## Open Decisions

- None recorded.

