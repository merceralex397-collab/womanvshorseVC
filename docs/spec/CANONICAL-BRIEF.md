# Canonical Brief — Woman vs Horse VC

## Project Summary

A 3D low-poly arena action game for Android where a warrior woman fights waves of enemy horses. Built with Godot 4.6, using 3D models generated via the blender-agent MCP server. GLB exports imported into Godot. Stylized low-poly art direction.

## Goals

- Playable wave-based 3D combat game on Android
- 3D character and prop models generated via blender-agent MCP
- Low-poly stylized art direction (under 5000 tris per model)
- Touch controls: virtual joystick + attack buttons
- Progressive difficulty across waves

## Non-Goals

- No realistic/high-poly art
- No story/narrative
- No online features or IAP
- No save system

## Constraints

- 3D models generated via blender-agent MCP server (GLB format)
- Blender 4.5.0 at /home/pc/blender-4.5.0/blender
- Per-model budget: 2000-5000 triangles, 512x512 textures max
- Android (Godot 4.6 export), landscape, touch-only
- Fixed top-down orthographic camera

## Core Game Design

Same core loop as VA/VB: wave-based arena combat, virtual joystick movement, tap/hold attack, progressive difficulty. 3D camera is fixed top-down orthographic.

### Required 3D Models (via Blender-MCP)
1. **woman-warrior** — Warrior woman with sword, ~3000 tris
2. **horse-brown** — Basic brown horse enemy, ~2000 tris
3. **horse-black** — Fast black horse variant, ~2000 tris
4. **horse-war** — Armored war horse, ~4000 tris
5. **horse-boss** — Large boss horse, ~5000 tris
6. **arena-ground** — Flat grass arena with fence border, ~500 tris
7. **sword-projectile** — Thrown sword for ranged attack, ~200 tris
8. **heart-pickup** — Health pickup item, ~100 tris

### Asset Pipeline
- Asset briefs in assets/briefs/ drive Blender-MCP tool sequences
- Exported GLB files in assets/models/
- Godot auto-import on project load
- Provenance tracked in assets/PROVENANCE.md

## Blocking Decisions

- All resolved. Blender-MCP route confirmed. Low-poly style confirmed.

## Backlog Readiness

- Ready for ticket generation. Asset briefs need creation first.

## Acceptance Signals

- APK compiles and installs on Android
- All 3D models load correctly in Godot (no import errors)
- Models within triangle budget
- All waves playable with 3D visuals
- assets/PROVENANCE.md tracks all generated models

## Product Finish Contract

- deliverable_kind: Android game APK with 3D graphics
- placeholder_policy: No placeholder models. Blender-MCP generated assets only.
- visual_finish_target: Low-poly 3D top-down. Stylized colors. Clean silhouettes.
- audio_finish_target: Minimal SFX from open sources or procedural.
- content_source_plan: 3D models via blender-agent MCP. Audio from open sources.
- licensing_or_provenance_constraints: AI-generated models (CC0). Full provenance tracking.
- finish_acceptance_signals: APK compiles. 3D models import cleanly. All waves playable.
