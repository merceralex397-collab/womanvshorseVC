# Plan: SETUP-002 — Create Player Controller

## 1. Scope

Create a standalone player character scene (`scenes/player/player.tscn`) with:
- `CharacterBody3D` root node
- `CollisionShape3D` child for physical collision
- `Area3D` placeholder child named `AttackArea` (to be wired in CORE-001)
- `player_controller.gd` GDScript controller with XZ-plane movement via `move_and_slide`

## 2. Files / Systems Affected

| Path | Action |
| --- | --- |
| `scenes/player/player.tscn` | Create — CharacterBody3D scene with CollisionShape3D + AttackArea children |
| `scripts/player_controller.gd` | Create — GDScript with XZ movement, move_and_slide |

Allowed paths: `scenes/player/`, `scripts/`, `scenes/`

## 3. Implementation Steps

### Step 1 — Create `scenes/player/` directory
Ensure `scenes/player/` exists as a valid Godot scene subdirectory.

### Step 2 — Create `scenes/player/player.tscn`

Structure:
```
CharacterBody3D (root, type_id: "CharacterBody3D")
├── CollisionShape3D (child)
└── AttackArea (Area3D, child, placeholder — wired in CORE-001)
```

- `CharacterBody3D` root node name: `Player`
- `CollisionShape3D` uses `CapsuleShape3D` (standard for character bodies in Godot)
- `AttackArea` is an `Area3D` node left empty as a placeholder stub; it will receive area-based hitbox logic in CORE-001
- No model (GLB) is required at this stage — visual representation is out of scope for SETUP-002

### Step 3 — Create `scripts/player_controller.gd`

```gdscript
extends CharacterBody3D

@export var speed: float = 5.0
@export var gravity: float = -20.0

func _physics_process(delta: float) -> void:
    # Get input (placeholder — to be replaced with joystick input in CORE-004)
    var input_dir := Vector3.ZERO
    input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_dir.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
    input_dir = input_dir.normalized()

    # Apply movement on XZ plane
    velocity.x = input_dir.x * speed
    velocity.z = input_dir.z * speed
    velocity.y = gravity * delta  # minimal Y gravity to keep grounded

    move_and_slide()
```

Key design decisions:
- **XZ plane only**: `velocity.x` and `velocity.z` driven by input; `velocity.y` carries minimal gravity to prevent floating-point drift
- **`move_and_slide()`**: Godot 4 canonical character locomotion; handles floor, collisions
- **`speed` exported**: allows per-wave tuning later via scene inheritance or exports
- **Input stubs**: mapped to Godot input actions (`move_left/right/forward/back`) — placeholder; actual touch/joystick wiring is CORE-004
- No attack logic here — `AttackArea` is a dormant `Area3D` child; wiring belongs to CORE-001

### Step 4 — Attach `player_controller.gd` to `Player` root node
In `player.tscn`, set the root `CharacterBody3D`'s script to `player_controller.gd`.

### Step 5 — Validate scene loads cleanly
```bash
godot4 --headless --path /home/rowan/womanvshorseVC --quit
```
Exit code 0 confirms the scene and script parse without errors.

## 4. Acceptance Criteria Mapping

| # | Criterion | Verification |
| --- | --- | --- |
| AC-1 | `scenes/player/player.tscn` exists with `CharacterBody3D` root | File exists; Godot parses root node type as `CharacterBody3D` |
| AC-2 | `player_controller.gd` with `move_and_slide` movement | Script file exists; contains `move_and_slide()` call |
| AC-3 | Placeholder `AttackArea` `Area3D` child | `player.tscn` contains `Area3D` node named `AttackArea` |
| AC-4 | Scene loads without errors | `godot4 --headless --path . --quit` → exit 0 |

## 5. Risks & Assumptions

| Risk | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- |
| Input actions (`move_left`, etc.) not defined in `project.godot` | Low | Player cannot move during manual testing | Actions are standard Godot input map entries; pre-existing or trivially added; not a blocker for scene structure |
| `AttackArea` placeholder conflicts with later hitbox wiring | Low | CORE-001 must rename or reuse this node | `AttackArea` is a clearly named stub; CORE-001 will add body/area children or replace contents |

**Assumptions**:
- SETUP-001 trusted; arena scene exists and loads
- Top-down XZ movement is the correct plane; Y is up
- Godot 4 `CharacterBody3D` + `move_and_slide` is the intended locomotion pattern (per canonical brief)

## 6. Blockers

- **None**. SETUP-001 is `done/trusted`; no decision blockers exist; implementation can proceed immediately.

## 7. Post-Closeout Dependency Note

`SETUP-002` is a dependency of `CORE-001` ("Implement 3D attack system"). `CORE-001` will wire the `AttackArea` child into the hitbox system. No other tickets depend on SETUP-002's internal structure.
