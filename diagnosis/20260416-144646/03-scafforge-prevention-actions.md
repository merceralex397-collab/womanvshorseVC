# Scafforge Prevention Actions

## Package Changes Required

### ACTION-001

- source_finding: CYCLE002
- change_target: scafforge-audit diagnosis contract
- why_it_prevents_recurrence: Teach audit to stop repeated diagnosis-pack churn when the repo has no newer package or process-version change; require Scafforge package work before the next subject-repo audit.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-002

- source_finding: EXEC-BLENDER-001
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

- source_finding: FINISH002
- change_target: scafforge-audit diagnosis contract
- why_it_prevents_recurrence: Refresh managed workflow docs, tools, and validators together so repair replaces drift instead of layering new semantics over old ones.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-005

- source_finding: SESSION003
- change_target: scafforge-audit transcript chronology and causal diagnosis surfaces
- why_it_prevents_recurrence: Reject unsupported stage probing and explicit workflow bypass attempts in both generated tools and prompt hardening.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun transcript-backed audit coverage plus the related curated GPTTalker fixture family

### ACTION-006

- source_finding: SKILL002
- change_target: project-skill-bootstrap and agent-prompt-engineering surfaces
- why_it_prevents_recurrence: Make the generated `ticket-execution` skill the canonical lifecycle explainer so weaker models do not have to reverse-engineer the state machine from tool errors.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

## Validation and Test Updates

- CYCLE002: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- EXEC-BLENDER-001: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family.

- EXEC-REMED-001: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family.

- FINISH002: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- SESSION003: rerun transcript-backed audit coverage plus the related curated GPTTalker fixture family.

- SKILL002: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

## Documentation or Prompt Updates

- FINISH002: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

- SESSION003: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

- SKILL002: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

## Open Decisions

- None recorded.

