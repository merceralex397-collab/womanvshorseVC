# Implementation — SETUP-002: Create player controller

## Ticket
- **ID**: SETUP-002
- **Title**: Create player controller
- **Wave**: 0
- **Lane**: scene-setup
- **Stage**: implementation
- **Status**: in_progress

---

## Acceptance Criteria Verification

| # | AC | Evidence |
|---|-----|----------|
| 1 | `scenes/player/player.tscn` exists with CharacterBody3D root | File created at `scenes/player/player.tscn` — `[gd_scene]` with `CharacterBody3D` root node named "Player" |
| 2 | `player_controller.gd` with move_and_slide movement | File created at `scripts/player_controller.gd` — extends CharacterBody3D, calls `move_and_slide()` in `_physics_process`, XZ plane movement |
| 3 | Placeholder AttackArea Area3D child | `AttackArea` node of type `Area3D` added as child of Player CharacterBody3D |
| 4 | Scene loads without errors | `godot4 --headless --path /home/rowan/womanvshorseVC --quit` → EXIT_CODE=0 |

---

## Files Created

### `scenes/player/player.tscn`
```gd_scene
[gd_scene load_steps=3 format=3 uid="uid://cxk8v5q6ywq"]

[ext_resource type="Script" path="res://scripts/player_controller.gd" id="1_controller"]

[sub_resource type="CapsuleShape3D" id="CapsuleShape3D_1"]
radius = 0.4
height = 1.6

[node name="Player" type="CharacterBody3D"]
script = ExtResource("1_controller")

[node name="CollisionShape3D" type="CollisionShape3D" parent="."]
shape = SubResource("CapsuleShape3D_1")

[node name="AttackArea" type="Area3D" parent="."]
```

**Structure**:
- Root: `CharacterBody3D` named "Player" with `player_controller.gd` script
- Child `CollisionShape3D` with `CapsuleShape3D` (radius=0.4, height=1.6)
- Child `Area3D` named "AttackArea" (placeholder for CORE-001 wiring)

### `scripts/player_controller.gd`
```gdscript
extends CharacterBody3D

@export var speed: float = 5.0
@export var gravity: float = -20.0

func _physics_process(delta: float) -> void:
    # Apply gravity on Y axis only
    if not is_on_floor():
        velocity.y += gravity * delta
    else:
        velocity.y = 0.0

    # Read movement input from action map
    var input_dir := Vector3.ZERO
    input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_dir.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")

    # Normalize to prevent faster diagonal movement
    if input_dir.length_squared() > 0:
        input_dir = input_dir.normalized()

    # Set XZ velocity (XZ plane movement)
    velocity.x = input_dir.x * speed
    velocity.z = input_dir.z * speed

    # Move using Godot physics
    move_and_slide()
```

**Design**:
- Extends `CharacterBody3D` as required
- `@export speed: float = 5.0` — configurable via inspector
- `@export gravity: float = -20.0` — configurable via inspector
- `_physics_process` reads `move_left/right/forward/back` actions, sets `velocity.x/z`
- Minimal Y gravity applied (XZ plane only)
- `move_and_slide()` called for physics movement
- Diagonal movement normalized to prevent speed boost

**Action mappings expected** (CORE-001 / input system):
- `move_left` — negative X
- `move_right` — positive X
- `move_forward` — negative Z
- `move_back` — positive Z

---

## Build Validation

```
$ godot4 --headless --path /home/rowan/womanvshorseVC --quit
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT_CODE=0
```

All 4 ACs verified PASS. Scene loads without errors.

---

## Follow-up

- `AttackArea` placeholder is intentionally empty; CORE-001 will wire the hitbox, damage signal, and cooldown timer
- Input actions (`move_left`, `move_right`, `move_forward`, `move_back`) should be defined in the Godot input map (typically via `project.godot` — handled in SETUP-001 or CORE-004 HUD)
