# REMED-007: Android-targeted Godot repo is missing export surfaces or debug APK runnable proof

## Summary

Remediate EXEC-GODOT-005a by correcting the validated issue and rerunning the relevant quality checks. Affected surfaces: project.godot, export_presets.cfg, android.

## Wave

10

## Lane

remediation

## Parallel Safety

- parallel_safe: false
- overlap_risk: low

## Stage

closeout

## Status

done

## Trust

- resolution_state: superseded
- verification_state: reverified
- finding_source: EXEC-GODOT-005a
- source_ticket_id: REMED-002
- source_mode: split_scope

## Depends On

None

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] The validated finding `EXEC-GODOT-005a` no longer reproduces.
- [ ] Current quality checks rerun with evidence tied to the fix approach: Emit export_presets.cfg and android/ surfaces at scaffold time. Block RELEASE-001 closeout until debug APK runnable proof exists at the canonical path.

## Artifacts

- None yet

## Notes


