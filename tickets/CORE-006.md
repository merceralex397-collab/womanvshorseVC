# CORE-006: Enemy variants with model swapping

## Summary

Create the enemy variant system that configures horse_base instances with different stats and GLB models. Each variant (brown, black, war, boss) loads its corresponding model from `assets/models/` and overrides base stats (speed, health, damage, score). The wave spawner uses variant IDs to spawn the correct type.

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

## Depends On

- CORE-002
- MODEL-001
- MODEL-002
- MODEL-003
- MODEL-004
- MODEL-005

## Decision Blockers

- None

## Acceptance Criteria

- [ ] `scripts/enemies/horse_variants.gd` exists with variant definitions
- [ ] Each variant defines: model_path, speed, health, damage, score_value
- [ ] Variant data: brown (base), black (fast/low-hp), war (slow/high-hp), boss (large/high-hp)
- [ ] horse_base.gd loads correct GLB model based on variant ID
- [ ] Model swap works at runtime (instance model, add as child)
- [ ] Wave spawner can request specific variant types
- [ ] All variant models load without errors

## Artifacts

- None yet

## Notes

- Use a Resource or Dictionary for variant data
- Model paths: `res://assets/models/horse-brown.glb`, etc.
- Boss variant should be scaled up 1.3x in addition to model size
