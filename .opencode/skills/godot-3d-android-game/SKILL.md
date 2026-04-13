---
name: godot-3d-android-game
description: Hold Godot 4.6 3D game patterns for this Android arena game. Use when implementing scenes, importing GLB models, setting up orthographic camera, or writing GDScript for 3D gameplay.
---

# Godot 4.6 3D Android Game Patterns

Before applying these rules, call `skill_ping` with `skill_id: "godot-3d-android-game"` and `scope: "project"`.

## Project Configuration

- **Engine**: Godot 4.6
- **Renderer**: Forward+ (configured in project.godot)
- **Platform**: Android (landscape, touch-only)
- **Camera**: Fixed top-down orthographic
- **Art style**: Low-poly 3D, stylized colors
- **Model format**: GLB (GLTF Binary) from Blender-MCP

## Current repo state

- The repo already has `project.godot`, `export_presets.cfg`, `android/`, `assets/`, `tickets/`, `docs/`, and `.opencode/`.
- The repo does **not** currently prove a settled `scenes/` / `scripts/` runtime tree. Do not invent scene names or script paths without checking the live repo first.
- Current implementation guidance should stay asset-first: brief -> Blender-MCP `.glb` -> Godot import validation -> gameplay wiring.

## GLB Import Workflow

1. Create or update the asset brief in `assets/briefs/<asset-name>.md`.
2. Generate the model through the Blender-MCP flow and export `assets/models/<asset-name>.glb`.
3. Record provenance in `assets/PROVENANCE.md`.
4. Validate Godot import with `/home/pc/.local/bin/godot --headless --path /home/pc/projects/womanvshorseVC --quit`.
5. Only after the import surface is proven should a ticket claim the model is ready for gameplay scene wiring.

## Orthographic Camera Setup

Key rules:
- Camera is FIXED — no player-following camera code needed
- Orthographic size determines visible arena area
- All gameplay happens on the XZ plane (Y is up)
- Shadows work with orthographic but keep DirectionalLight3D angle steep

## Gameplay implementation rules

- Keep player, enemy, arena, and pickup models within the triangle budgets defined in the canonical brief.
- Favor clear silhouettes and color contrast over small surface detail because the camera is fixed top-down.
- Do not add runtime scene architecture to a ticket unless the current repo already contains or the current plan explicitly defines that structure.
- When creating gameplay scenes later, prefer `CharacterBody3D` for player and horse actors and keep combat/readability centered on the XZ plane.
- Android UI and touch controls must remain landscape-first with large touch targets.

## Validation Commands

```bash
/home/pc/.local/bin/godot --headless --path /home/pc/projects/womanvshorseVC --quit
/home/pc/.local/bin/godot --headless --path /home/pc/projects/womanvshorseVC --export-debug "Android Debug" build/android/womanvshorseVC-debug.apk
ls -lh build/android/womanvshorseVC-debug.apk
```

## Common Pitfalls

- Do not assume `godot` is on PATH; use `/home/pc/.local/bin/godot` when needed.
- Do not declare an asset imported cleanly without running the headless project load command.
- Do not assume current repo structure from other Woman vs Horse variants; VC must be validated from its own tree.
- Do not treat a missing or failed APK export as a docs-only issue. `EXEC-GODOT-005a` stays open until the real debug APK proof exists.
