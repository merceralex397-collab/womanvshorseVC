---
name: stack-standards
description: Hold the project-local standards for languages, frameworks, validation, and runtime assumptions. Use when planning or implementing work that should follow repo-specific engineering conventions.
---

# Stack Standards

Before applying these rules, call `skill_ping` with `skill_id: "stack-standards"` and `scope: "project"`.

Current scaffold mode: `Godot 4.6 3D Android Game`

## Stack: Godot 4.6 + GDScript + Blender-MCP

### Language & Engine
- **Engine**: Godot 4.6 with Forward+ renderer
- **Language**: GDScript (static typing preferred: `var x: int = 0`)
- **Platform**: Android (landscape, touch-only)
- **3D Pipeline**: Blender-MCP → GLB → Godot auto-import

### Code Quality
- Write GDScript for readability first; optimize only when profiled evidence justifies it.
- Keep functions and methods focused on a single responsibility; extract helpers when a unit exceeds ~40 lines.
- Use `## doc comment` on exported variables and public methods.
- Use `class_name` declarations for all scripts that need cross-referencing.
- Delete dead code instead of commenting it out; use version control to recover removed code.
- Use static typing in GDScript: `func foo(bar: int) -> String:`
- Prefer signals over direct method calls for decoupled communication.

### Quality Gate Commands

```bash
# Project load verification (primary gate)
godot --headless --check-only --path .

# Scene reference integrity
grep -r "res://" scenes/ scripts/ --include="*.tscn" --include="*.gd" | grep -v ".import"

# Android debug export
godot --headless --export-debug "Android" build/android/womanvshorsevc-debug.apk

# Blender-MCP model validation (per model)
# Run quality_validate tool via blender-agent MCP after each model generation
```

### Validation
- All external inputs (touch events, file loads) must be null-checked before use.
- Use `is_instance_valid(node)` before accessing freed nodes.
- Use `@onready` for node references, not `_ready()` assignments.
- Write GUT or built-in test scenes for correctness-critical paths.

### Dependencies
- No external Godot plugins unless explicitly approved in the canonical brief.
- Blender-MCP is the only external tool dependency (for model generation only).
- Android SDK/NDK paths configured in Editor Settings, not hardcoded.

### 3D-Specific Standards
- All gameplay on XZ plane, Y is up.
- Fixed top-down orthographic camera (Camera3D, PROJECTION_ORTHOGONAL).
- CharacterBody3D for player and enemies; StaticBody3D for environment.
- Collision layers: Player=1, Enemies=2, PlayerAttacks=3, EnemyAttacks=4, Boundaries=5, Pickups=6.
- GLB models in `assets/models/`, never modify imported `.import` files manually.
- 1 unit = 1 meter in both Blender and Godot.

### Process
- Use ticket tools to track work; do not silently advance stages without updating ticket state.
- Artifacts produced by each stage must be registered via `artifact_write` / `artifact_register`.
- Smoke tests run on the real binary or export target, not on a mocked surrogate.
- MODEL tickets must reference the asset brief and follow the `blender-mcp-workflow` skill.
- After generating any model, update `assets/PROVENANCE.md`.
