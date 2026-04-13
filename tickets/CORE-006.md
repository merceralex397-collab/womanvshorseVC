# CORE-006: Enemy variants with model swapping

## Summary

Create variant system that configures horse_base with different GLB models and stats for brown, black, war, and boss types.

## Wave

2

## Lane

core-gameplay

## Parallel Safety

- parallel_safe: false
- overlap_risk: medium

## Stage

planning

## Status

todo

## Trust

- resolution_state: open
- verification_state: suspect
- finding_source: None
- source_ticket_id: None
- source_mode: None

## Depends On

CORE-002, MODEL-001, MODEL-002, MODEL-003, MODEL-004, MODEL-005

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] horse_variants.gd with variant definitions
- [ ] Each variant: model_path, speed, health, damage, score_value
- [ ] horse_base loads correct GLB at runtime
- [ ] Wave spawner can request variant types
- [ ] All models load without errors

## Artifacts

- None yet

## Notes

- Use a Resource or Dictionary for variant data
- Model paths: `res://assets/models/horse-brown.glb`, etc.
- Boss variant should be scaled up 1.3x in addition to model size
