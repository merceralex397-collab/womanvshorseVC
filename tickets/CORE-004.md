# CORE-004: 3D HUD (CanvasLayer)

## Summary

Create in-game HUD overlay with health, wave number, score, enemy count, virtual joystick, and attack button.

## Wave

2

## Lane

ui

## Parallel Safety

- parallel_safe: true
- overlap_risk: low

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

SETUP-001

## Follow-up Tickets

None

## Decision Blockers

None

## Acceptance Criteria

- [ ] hud.tscn exists with CanvasLayer root
- [ ] Displays health, wave, score, enemy count
- [ ] Virtual joystick and attack button placeholders
- [ ] Touch-friendly sizing (48dp minimum)
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- CanvasLayer renders on top of 3D scene
- Use MarginContainer/HBoxContainer for layout
- Connect to game signals for reactive updates
