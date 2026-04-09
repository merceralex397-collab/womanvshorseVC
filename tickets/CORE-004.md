# CORE-004: 3D HUD (CanvasLayer)

## Summary

Create the in-game HUD as a CanvasLayer overlay. Displays player health (hearts or bar), current wave number, score, and enemy count. Updates reactively via signals from game systems. Must work at Android landscape resolution with touch-friendly sizing.

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

## Depends On

- SETUP-001

## Decision Blockers

- None

## Acceptance Criteria

- [ ] `scenes/ui/hud.tscn` exists with CanvasLayer root
- [ ] `scripts/ui/hud.gd` attached
- [ ] Displays player health (bar or hearts)
- [ ] Displays current wave number
- [ ] Displays score
- [ ] Displays remaining enemy count
- [ ] Virtual joystick placeholder on left side of screen
- [ ] Attack button placeholder on right side of screen
- [ ] UI elements minimum 48dp for touch targets
- [ ] Scene loads without errors

## Artifacts

- None yet

## Notes

- CanvasLayer renders on top of 3D scene
- Use MarginContainer/HBoxContainer for layout
- Connect to game signals for reactive updates
