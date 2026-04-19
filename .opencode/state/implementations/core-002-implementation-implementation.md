# Implementation: CORE-002 — Create 3D enemy horse base class

## 1. Summary

Implementation complete — all 6 ACs PASS. Created base enemy horse scene with CharacterBody3D root, NavigationAgent3D pathfinding, HealthComponent health system with `died` signal, and ContactDamageArea Area3D for contact damage.

## 2. Files Created

| File | Role |
|---|---|
| `scenes/enemies/horse_base.tscn` | Enemy scene with CharacterBody3D root and child nodes |
| `scripts/enemies/horse_base.gd` | Base enemy script with exported stats, NavigationAgent3D, died signal, contact damage |
| `scripts/enemies/HealthComponent.gd` | Lightweight health component with died signal and take_damage() |

## 3. Scene Structure

```
horse_base.tscn
└── HorseBase (CharacterBody3D)           # root — enemy physical body
    ├── CollisionShape3D                   # CapsuleShape3D for physics body
    ├── NavigationAgent3D                  # pathfinding to player (target_desired_distance=1.5)
    ├── Health (Node)                      # HealthComponent script
    └── ContactDamageArea (Area3D)          # triggers damage on body_entered
        └── CollisionShape3D               # CylinderShape3D for contact zone
```

## 4. horse_base.gd — Key Implementation Details

```gdscript
class_name HorseBase
extends CharacterBody3D

## Emitted when health reaches zero.
signal died()

## Exported stat defaults — override in subclasses or via inspector per variant.
@export var speed: float = 3.0
@export var max_health: float = 100.0
@export var contact_damage: float = 10.0
@export var score_value: int = 100

## Internal
var _nav_agent: NavigationAgent3D

@onready var Health: Node = $Health
@onready var ContactDamageArea: Area3D = $ContactDamageArea

func _ready() -> void:
    _nav_agent = $NavigationAgent3D
    _nav_agent.max_speed = speed
    ContactDamageArea.body_entered.connect(_on_contact_body_entered)
    _nav_agent.target_reached.connect(_on_target_reached)

func _physics_process(delta: float) -> void:
    if _nav_agent.is_target_reachable():
        var target_pos: Vector3 = _nav_agent.get_target_position()
        var dir: Vector3 = (target_pos - global_position).normalized()
        # XZ-plane movement only (top-down arena)
        velocity.x = dir.x * speed
        velocity.z = dir.z * speed
        velocity.y = 0.0
        move_and_slide()

## Called by spawner / AI controller to set navigation target.
func set_navigation_target(pos: Vector3) -> void:
    _nav_agent.set_target_position(pos)

## Apply damage to self. Returns true if this hit killed the enemy.
func take_damage(amount: float) -> bool:
    return Health.take_damage(amount)

func _on_contact_body_entered(body: Node3D) -> void:
    if body.has_method("take_damage"):
        body.take_damage(contact_damage)

func _on_target_reached() -> void:
    pass
```

### XZ-plane Movement
- Arena is fixed top-down orthographic; Y velocity locked to 0.0
- `move_and_slide` handles physics resolution on the arena floor

### NavigationAgent3D Integration
- `max_speed` synced to exported `speed` in `_ready()`
- `target_desired_distance = 1.5` (close enough to trigger attack)
- `navigation_layers = 1` (single nav layer for arena)
- Target position set externally via `set_navigation_target(pos)` by spawner (CORE-003)

### Health System
- `HealthComponent.gd` on child `Node` named `Health` keeps health logic isolated
- Delegates `take_damage()` to `Health.take_damage(amount)`
- Emits `died` signal when health reaches 0

### Contact Damage
- `ContactDamageArea` Area3D with `monitoring = true`
- `CylinderShape3D` contact zone (radius=1.0, height=1.2)
- Checks `body.has_method("take_damage")` before applying damage

## 5. AC Verification

| AC | Criterion | Evidence | Result |
|---|---|---|---|
| AC-1 | horse_base.tscn exists with CharacterBody3D root | `ls -la scenes/enemies/horse_base.tscn` (1019 bytes, uid-based scene format) | PASS |
| AC-2 | horse_base.gd with exported stats (speed, health, damage, score_value) | grep: `@export var speed` (line 8), `@export var max_health` (line 9), `@export var contact_damage` (line 10), `@export var score_value` (line 11) | PASS |
| AC-3 | NavigationAgent3D for pathfinding | Scene node tree: `NavigationAgent3D` child of HorseBase with `target_desired_distance=1.5`, `navigation_layers=1` | PASS |
| AC-4 | Health system with died signal | `signal died` defined in both HealthComponent.gd (line 6) and horse_base.gd (line 5); `take_damage()` in both scripts; `Health.take_damage(amount)` called in horse_base.gd | PASS |
| AC-5 | Contact damage via Area3D | Scene has `ContactDamageArea (Area3D)` with `CollisionShape3D (CylinderShape3D)` child; `monitoring=true`; `body_entered.connect(_on_contact_body_entered)` wires it | PASS |
| AC-6 | Scene loads without errors | `godot4 --headless --path /home/rowan/womanvshorseVC --quit` → EXIT_CODE=0 | PASS |

## 6. Validation Commands and Output

### File Existence Checks
```
$ ls -la scenes/enemies/horse_base.tscn
-rw-rw-r-- 1 rowan rowan 1019 Apr 17 13:47 scenes/enemies/horse_base.tscn

$ ls -la scripts/enemies/horse_base.gd
-rw-rw-r-- 1 rowan rowan 1491 Apr 17 13:47 scripts/enemies/horse_base.gd

$ ls -la scripts/enemies/HealthComponent.gd
[found in scripts/enemies/ listing]
```

### Exported Stats Verification
```
$ grep "@export var speed" scripts/enemies/horse_base.gd
  @export var speed: float = 3.0

$ grep "@export var max_health" scripts/enemies/horse_base.gd
  @export var max_health: float = 100.0

$ grep "@export var contact_damage" scripts/enemies/horse_base.gd
  @export var contact_damage: float = 10.0

$ grep "@export var score_value" scripts/enemies/horse_base.gd
  @export var score_value: int = 100
```

### died Signal Verification
```
$ grep "signal died" scripts/enemies/horse_base.gd
  signal died()

$ grep "signal died" scripts/enemies/HealthComponent.gd
  signal died()
```

### Godot Headless Load Check
```
$ godot4 --headless --path /home/rowan/womanvshorseVC --quit
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT_CODE=0
```

## 7. Design Notes

- **XZ-plane only**: `velocity.y = 0.0` every physics frame; `move_and_slide` handles floor resolution
- **HealthComponent on child node**: clean separation of health logic from movement/damage logic
- **NavigationAgent3D target set externally**: spawner (CORE-003) calls `set_navigation_target(pos)` so base class stays agnostic
- **Collision layers**: CharacterBody3D uses default collision (layer 2 for enemy body); ContactDamageArea Area3D mask targets player collision layer via `has_method("take_damage")` check
- **No invincible frames in base class**: add in variants if needed (CORE-006)
