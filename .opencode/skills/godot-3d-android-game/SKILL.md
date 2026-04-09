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

## Directory Structure

```
project.godot
export_presets.cfg
scenes/
  main.tscn            # Main scene (autoload entry)
  arena/
    arena.tscn         # 3D arena scene (Node3D root)
  player/
    player.tscn        # Player scene (CharacterBody3D)
  enemies/
    horse_base.tscn    # Base horse enemy (CharacterBody3D)
  ui/
    hud.tscn           # In-game HUD (CanvasLayer)
    title_screen.tscn  # Title screen (Control)
    game_over.tscn     # Game over screen (Control)
scripts/
  player/
    player_controller.gd
    attack_system.gd
  enemies/
    horse_base.gd
    horse_variants.gd
    wave_spawner.gd
  managers/
    game_manager.gd
    wave_manager.gd
  ui/
    hud.gd
    title_screen.gd
    game_over.gd
assets/
  models/              # GLB files from Blender-MCP
  audio/               # SFX and music
  briefs/              # Asset description briefs
  PROVENANCE.md        # AI-generated asset tracking
```

## GLB Import Workflow

1. Place `.glb` file in `assets/models/`
2. Godot auto-imports on project load (creates `.import` file)
3. To use in a scene:
   - Instance the GLB as a child of the appropriate node
   - Or load via script: `var model = load("res://assets/models/woman-warrior.glb")`
4. For CharacterBody3D characters:
   - Create a scene with CharacterBody3D root
   - Add CollisionShape3D child
   - Instance GLB model as child for visuals
   - Attach movement/AI script to root

```gdscript
# Example: Loading a GLB model at runtime
var model_scene = load("res://assets/models/horse-brown.glb")
var model_instance = model_scene.instantiate()
add_child(model_instance)
```

## Orthographic Camera Setup

```gdscript
# Camera3D settings for top-down orthographic
# In the arena scene, add Camera3D with:
#   projection = PROJECTION_ORTHOGONAL
#   size = 20.0  (adjustable for arena size)
#   position = Vector3(0, 15, 0)
#   rotation_degrees = Vector3(-90, 0, 0)
#   near = 0.1
#   far = 100.0
```

Key rules:
- Camera is FIXED — no player-following camera code needed
- Orthographic size determines visible arena area
- All gameplay happens on the XZ plane (Y is up)
- Shadows work with orthographic but keep DirectionalLight3D angle steep

## 3D Node Hierarchy Patterns

### Player Character
```
CharacterBody3D (player)
├── CollisionShape3D (capsule or box)
├── GLB_Model_Instance (woman-warrior.glb)
├── AttackArea (Area3D)
│   └── CollisionShape3D
└── AnimationPlayer (if model has animations)
```

### Enemy Horse
```
CharacterBody3D (horse)
├── CollisionShape3D (box, sized to horse)
├── GLB_Model_Instance (horse-*.glb)
├── HitboxArea (Area3D)
│   └── CollisionShape3D
├── NavigationAgent3D
└── HealthComponent (Node)
```

### Arena Scene
```
Node3D (arena_root)
├── Camera3D (orthographic, top-down)
├── DirectionalLight3D (sun)
├── GLB_Arena_Ground (arena-ground.glb)
├── Player (player.tscn instance)
├── EnemyContainer (Node3D)
├── WaveSpawner (Node3D)
└── CanvasLayer (HUD)
    └── HUD (hud.tscn instance)
```

## 3D Movement (CharacterBody3D)

```gdscript
extends CharacterBody3D

@export var speed: float = 5.0

func _physics_process(delta: float) -> void:
    var input_dir := Vector2.ZERO
    # Touch input via virtual joystick or Input actions
    input_dir.x = Input.get_axis("move_left", "move_right")
    input_dir.y = Input.get_axis("move_up", "move_down")

    var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
    if direction:
        velocity = direction * speed
        # Face movement direction
        look_at(global_position + direction, Vector3.UP)
    else:
        velocity = velocity.move_toward(Vector3.ZERO, speed)

    move_and_slide()
```

## Collision Layers (Recommended)

- Layer 1: Player body
- Layer 2: Enemy bodies
- Layer 3: Player attacks (Area3D)
- Layer 4: Enemy attacks (Area3D)
- Layer 5: Arena boundaries
- Layer 6: Pickups

## Android Touch Input

- Use a virtual joystick node for movement (left side of screen)
- Attack button(s) on right side of screen
- All UI elements must be sized for touch (minimum 48dp tap targets)
- Test with `Project > Project Settings > Display > Window > Stretch > Mode = canvas_items`
- Landscape orientation only: `display/window/handheld/orientation = "landscape"`

## Validation Commands

```bash
# Check project loads (headless)
godot --headless --check-only --path .

# Verify scene references (look for missing .tscn/.gd)
grep -r "res://" scenes/ scripts/ --include="*.tscn" --include="*.gd" | grep -v ".import"

# Check for GDScript syntax errors
godot --headless --script scripts/player/player_controller.gd --check-only 2>&1

# Android export (debug APK)
godot --headless --export-debug "Android" build/android/womanvshorsevc-debug.apk
```

## Common Pitfalls

- **Y-up convention**: Godot 4 uses Y-up. GLB from Blender exports Y-up by default. Do NOT apply rotation corrections unless models appear wrong.
- **Scale mismatch**: Blender uses meters, Godot uses meters. 1 unit = 1 meter in both. Verify in asset briefs.
- **3D physics**: Use `move_and_slide()` not `move_and_collide()` for character movement. Set up collision layers to avoid player-enemy-attack overlap confusion.
- **CharacterBody3D vs RigidBody3D**: Use CharacterBody3D for player and enemies (direct velocity control). RigidBody3D only for physics-driven objects.
- **Orthographic click/touch**: `camera.project_ray_origin()` and `project_ray_normal()` behave differently in orthographic mode. Use `camera.project_position()` for screen-to-world.
