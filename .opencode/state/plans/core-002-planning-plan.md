# Plan: CORE-002 — Create 3D enemy horse base class

## 1. Scope

Create a reusable base enemy horse scene and script for the 3D arena game. This ticket establishes the core enemy entity shape — NavigationAgent3D pathfinding, health system with `died` signal, and contact-damage Area3D — that variant tickets (CORE-006 and beyond) will subclass with model swaps and per-type stat overrides.

## 2. Files / Systems Affected

| File | Role |
|---|---|
| `scenes/enemies/horse_base.tscn` | Enemy scene with CharacterBody3D root and child nodes |
| `scripts/enemies/horse_base.gd` | Base enemy script with exported stats, NavigationAgent3D, health, died signal, contact damage |

## 3. Scene Structure

```
horse_base.tscn
└── CharacterBody3D                    # root — enemy physical body
    ├── CollisionShape3D               # CapsuleShape3D for physics body
    ├── NavigationAgent3D               # pathfinding to player
    ├── HealthComponent (Node)         # inline health system (or script-attached)
    └── ContactDamageArea (Area3D)      # triggers damage on body_entered
        └── CollisionShape3D           # cylinder/sphere shape for contact zone
```

### Node Details

- **CharacterBody3D root**: sets the kinematic movement base. Collision layer 2 (enemy), collision mask 1 (world). Motion mode = FLOOR. Safe to move via `move_and_slide` against arena floor.
- **NavigationAgent3D**: `target_desired_distance = 1.5`, `navigation_layers = 1`. Height a little above floor (y=0.5). Updated every physics frame in `_physics_loop`.
- **ContactDamageArea (Area3D)**: collision layer 0, mask = player collision layer (from project.godot; assumed layer 1). `monitoring = true`. Emits `body_entered` signal to trigger contact damage.
- **HealthComponent**: lightweight inline node. Exported `max_health: float = 100.0`. Internal `current_health: float`. Emits `died` when `current_health <= 0`. Can be represented as a named child Node with a script, or as properties directly on CharacterBody3D if a separate component node is excessive. Preference: separate `HealthComponent` script on a child `Node` named `Health` for clean separation.

## 4. Script Design — `horse_base.gd`

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
var current_health: float
var _nav_agent: NavigationAgent3D

@onready var Health: Node = $Health  # HealthComponent node
@onready var ContactDamageArea: Area3D = $ContactDamageArea

func _ready() -> void:
    current_health = max_health
    _nav_agent = $NavigationAgent3D
    ContactDamageArea.body_entered.connect(_on_contact_body_entered)
    # navigation target set externally by spawner or AI controller
    _nav_agent.target_reached.connect(_on_target_reached)

func _physics_loop(delta: float) -> void:
    if _nav_agent.is_target_reachable():
        var target_pos: Vector3 = _nav_agent.get_target_position()
        var dir: Vector3 = (target_pos - global_position).normalized()
        # move on XZ plane only (top-down arena)
        velocity.x = dir.x * speed
        velocity.z = dir.z * speed
        move_and_slide()

## Called by spawner / AI controller to set navigation target.
func set_navigation_target(pos: Vector3) -> void:
    _nav_agent.set_target_position(pos)

## Apply damage to self. Returns true if this hit killed the enemy.
func take_damage(amount: float) -> bool:
    current_health -= amount
    if current_health <= 0.0:
        died.emit()
        return true
    return false

func _on_contact_body_entered(body: Node3D) -> void:
    if body.has_method("take_damage"):   # player or other damageable
        body.take_damage(contact_damage)

func _on_target_reached() -> void:
    # optional: stop or attack behavior
    pass
```

### Key Design Decisions

- **XZ-plane movement only**: arena is fixed top-down orthographic; Y velocity stays at 0.
- **Health system as inline child node (`$Health`)**: separate `HealthComponent.gd` script keeps the health logic isolated and testable. HorseBase holds the reference but delegates health management.
- **ContactDamageArea uses `body_entered` check**: the Area3D mask targets the player collision layer; no direct collision with world geometry needed.
- **NavigationAgent3D target set externally**: the spawner (CORE-003) sets the target position via `set_navigation_target(pos)` so this base class stays agnostic to spawner logic.

## 5. NavigationAgent3D Configuration Notes

| Property | Value | Rationale |
|---|---|---|
| `max_speed` | synced to `@export var speed` | varies by variant |
| `target_desired_distance` | `1.5` | close enough to trigger attack |
| `navigation_layers` | `1` | single nav layer for arena |
| `path_height_offset` | `0.0` | flat arena |
| `agent_height` | not used (2D top-down mode) | — |
| `_nav_agent.path_desired_distance` | settable per variant | — |

Configuration done in scene via Inspector or via `_ready()` in script.

## 6. Health System Design

```
current_health: float (starts at max_health)
take_damage(amount: float) -> bool  # returns true if died
died: Signal  # emitted when health <= 0
```

No invincibility frames in the base class (add in variants if needed). Death triggers `died` signal — the spawner or world manager listens for this to clean up the node and update score.

## 7. AC Mapping Table

| # | Acceptance Criterion | Evidence Type |
|---|---|---|
| AC-1 | `horse_base.tscn` exists with CharacterBody3D root | File glob + Godot headless parse |
| AC-2 | `horse_base.gd` with exported stats (speed, health, damage, score_value) | File exists + grep `@export` for all 4 vars |
| AC-3 | NavigationAgent3D for pathfinding | Scene node tree inspection (NavigationAgent3D child) |
| AC-4 | Health system with `died` signal | Script contains `signal died` + `current_health` + `take_damage` |
| AC-5 | Contact damage via Area3D | Scene has Area3D named ContactDamageArea with CollisionShape3D child |
| AC-6 | Scene loads without errors | `godot --headless --path . --quit` exit code 0 |

## 8. Implementation Steps

1. Create directory `scenes/enemies/` if it does not exist.
2. Create `horse_base.tscn` with CharacterBody3D root.
3. Add `CollisionShape3D` as child of CharacterBody3D; set `CapsuleShape3D` collision shape.
4. Add `NavigationAgent3D` as child of CharacterBody3D; configure in Inspector or `_ready()`.
5. Create `scripts/enemies/` directory if needed.
6. Create `HealthComponent.gd` (lightweight node script with `current_health`, `max_health`, `take_damage()`, `died` signal).
7. Add a `Node` named `Health` as child of CharacterBody3D; attach `HealthComponent.gd`.
8. Create `horse_base.gd` with all exported vars, NavigationAgent3D integration, `died` signal wiring, contact damage Area3D setup.
9. Add `ContactDamageArea` (Area3D) as child of CharacterBody3D with `CollisionShape3D`.
10. Wire `ContactDamageArea.body_entered` to `_on_contact_body_entered`.
11. Save scene and script.
12. Run `godot --headless --path . --quit` to validate load.

## 9. Validation Plan

| Step | Command / Check | Pass Criterion |
|---|---|---|
| V-1 | `ls scenes/enemies/horse_base.tscn` | file exists |
| V-2 | `ls scripts/enemies/horse_base.gd` | file exists |
| V-3 | `grep -c "@export var speed" scripts/enemies/horse_base.gd` | >= 1 |
| V-4 | `grep -c "@export var max_health" scripts/enemies/horse_base.gd` | >= 1 |
| V-5 | `grep -c "@export var contact_damage" scripts/enemies/horse_base.gd` | >= 1 |
| V-6 | `grep -c "@export var score_value" scripts/enemies/horse_base.gd` | >= 1 |
| V-7 | `grep "signal died" scripts/enemies/horse_base.gd` | present |
| V-8 | Godot headless load check (scene parse) | exit code 0 |

## 10. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| NavigationServer not configured for arena bounds | low | high | SETUP-001 created arena scene; confirm NavigationRegion3D or baked navmesh exists in arena before runtime |
| ContactDamageArea damages non-player bodies | medium | medium | Area3D mask targets player collision layer only; add `is_player` check or group check in `_on_contact_body_entered` |
| HealthComponent node naming conflict with Godot built-in | low | low | Name it `Health` (not `HealthComponent`) to avoid any `health` property conflicts on CharacterBody3D |
| Speed export not synchronized to NavigationAgent3D.max_speed | low | medium | Set `_nav_agent.max_speed = speed` in `_ready()` |

## 11. Blockers

- **None.** SETUP-001 is done and its arena scene is trusted. All required context (player collision layers, arena bounds) is established.