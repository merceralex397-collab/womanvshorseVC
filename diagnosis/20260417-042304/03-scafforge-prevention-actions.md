# Scafforge Prevention Actions

## Package Changes Required

### ACTION-001

- source_finding: EXEC-BLENDER-001
- change_target: generated repo implementation and validation surfaces
- why_it_prevents_recurrence: Tighten generated review and QA guidance so runtime validation and test collection proof exist before closure.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family

### ACTION-002

- source_finding: FINISH002
- change_target: scafforge-audit diagnosis contract
- why_it_prevents_recurrence: Refresh managed workflow docs, tools, and validators together so repair replaces drift instead of layering new semantics over old ones.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-003

- source_finding: FINISH005
- change_target: ticket-pack-builder and ticket contract surfaces
- why_it_prevents_recurrence: Refresh managed workflow docs, tools, and validators together so repair replaces drift instead of layering new semantics over old ones.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun contract validation, smoke, and integration coverage for the affected managed surfaces

### ACTION-004

- source_finding: SESSION003
- change_target: scafforge-audit transcript chronology and causal diagnosis surfaces
- why_it_prevents_recurrence: Reject unsupported stage probing and explicit workflow bypass attempts in both generated tools and prompt hardening.
- change_class: safe package-managed workflow change unless a later human decision overrides scope or product intent.
- validation: rerun transcript-backed audit coverage plus the related curated GPTTalker fixture family

## Validation and Test Updates

- EXEC-BLENDER-001: rerun the generated-tool execution smoke coverage plus the relevant GPTTalker fixture family.

- FINISH002: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- FINISH005: rerun contract validation, smoke, and integration coverage for the affected managed surfaces.

- SESSION003: rerun transcript-backed audit coverage plus the related curated GPTTalker fixture family.

## Documentation or Prompt Updates

- FINISH002: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

- FINISH005: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

- SESSION003: keep the docs, prompts, and generated workflow surfaces aligned with the repaired state machine.

## Open Decisions

- None recorded.

