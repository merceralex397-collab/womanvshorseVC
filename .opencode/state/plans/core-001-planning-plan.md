# Planning Artifact: CORE-001 — Implement 3D Attack System

## 1. Scope

**Ticket**: CORE-001  
**Title**: Implement 3D attack system  
**Lane**: core-gameplay  
**Stage**: planning  
**Wave**: 2  
**Status**: todo → plan_review  

### Goal
Wire the player attack system with an Area3D hitbox, cooldown timer, and damage signal. The AttackArea node currently exists as a placeholder in `scenes/player/player.tscn` — this ticket activates it.

---

## 2. Files and Systems Affected

| Surface | Path | Change |
|---|---|---|
| Script | `scripts/attack_system.gd` | New — attack logic with cooldown and signal |
| Scene | `scenes/player/player.tscn` | Attach attack_system.gd to AttackArea; add Timer child |
| Input mapping | `project.godot` | Ensure `attack` action exists in input map |

### No changes to:
- `scripts/player_controller.gd` (already exists, movement only)
- `scenes/arena/arena.tscn` (arena is passive, no wiring needed here)

---

## 3. Scene Structure (Target)

```
player.tscn (CharacterBody3D)
├── CollisionShape3D
├── MeshInstance3D (visual body)
├── AttackArea (Area3D)          ← existing placeholder, CORE-001 wires it
│   ├── CollisionShape3D         ← needs shape + layer 2 mask
│   └── Timer                    ← new child: cooldown timer
└── player_controller.gd
```

**Node path after CORE-001**: `player/AttackArea` gets `attack_system.gd`; `player/AttackArea/Timer` is the cooldown Timer node.

---

## 4. Script Design: `attack_system.gd`

```gdscript
extends Area3D
class_name AttackSystem

signal hit(enemy: Node3D)

@export var cooldown_seconds: float = 0.4
@export var damage: int = 1

var _timer: Timer

func _ready() -> void:
    # Configure collision: detect layer 2 (enemies)
    collision.mask = 0b100  # layer 2 = bit 2 = 4; using mask 4 or 0b100
    collision.layer = 0     # AttackArea itself lives on no collision layer

    # Set up cooldown Timer as child
    _timer = Timer.new()
    _timer.name = "CooldownTimer"
    _timer.wait_time = cooldown_seconds
    _timer.one_shot = true
    add_child(_timer)

    # Body entered signal for hit detection
    body_entered.connect(_on_body_entered)


func attack() -> void:
    """Call this from player_controller when the player presses the attack input."""
    if _timer.is_stopped():
        _timer.start()
        # Small cooldown window — attack window is open during timer startup
        # The Area3D monitors while timer runs; no extra trigger needed
    # else: cooldown active, suppress attack


func _on_body_entered(body: Node3D) -> void:
    # Only emit hit during active cooldown window
    if not _timer.is_stopped():
        hit.emit(body)
```

### Key design decisions

| Decision | Rationale |
|---|---|
| `extends Area3D` | AttackArea is already an Area3D per SETUP-002 placeholder |
| `hit` signal with `enemy: Node3D` | Allows player_controller or other listeners to react to contact |
| Timer as child node, not `@export` | Timer is a proper Godot Node child; cleaner lifecycle than a standalone `wait_time` |
| `collision.mask = 0b100` | Layer 2 = bit index 2 = value 4; `mask` means "what this Area detects" |
| `collision.layer = 0` | AttackArea does not live on any collision layer itself; it only detects |
| `attack()` called by player_controller | player_controller already handles input; it calls `attack()` on AttackArea |

### Collision layer reference

| Layer | Use |
|---|---|
| Layer 1 | Player body (CharacterBody3D collision) |
| Layer 2 | Enemy bodies |

The AttackArea `mask` should be set to detect layer 2. In Godot 4, `collision.mask` is a bitmask; `0b100` (decimal 4) corresponds to layer 2.

---

## 5. Input Action

The `attack` action must exist in `project.godot` under `InputMap`. GDScript uses:
```gdscript
if Input.is_action_just_pressed("attack"):
    $AttackArea.attack()
```

This call lives in `player_controller.gd` which already handles movement. No changes to player_controller script structure are required beyond adding this one line in `_unhandled_input()`.

---

## 6. AC Mapping

| # | Acceptance Criterion | Evidence | Verification Method |
|---|---|---|---|
| AC-1 | attack_system.gd exists | File at `scripts/attack_system.gd` with correct class name | `test -f scripts/attack_system.gd && grep -c "class_name AttackSystem" scripts/attack_system.gd` |
| AC-2 | Area3D hitbox detects collision layer 2 | `collision.mask = 0b100` in `_ready()` | grep `collision.mask` in attack_system.gd |
| AC-3 | Cooldown timer prevents spam | Timer child created in `_ready()`, `attack()` guards on `is_stopped()` | grep `Timer` and `is_stopped()` in attack_system.gd |
| AC-4 | Damage signal emitted on hit | `signal hit(enemy: Node3D)` declared; `hit.emit(body)` in `_on_body_entered` | grep `signal hit` and `hit.emit` in attack_system.gd |
| AC-5 | Scene loads without errors | `godot4 --headless --path . --quit` exits 0 | `godot4 --headless --path /home/rowan/womanvshorseVC --quit; echo $?` → 0 |

---

## 7. Implementation Steps

1. **Write** `scripts/attack_system.gd` with the design above.
2. **Attach** `attack_system.gd` to the `AttackArea` node in `scenes/player/player.tscn`.
3. **Add** `CollisionShape3D` shape to `AttackArea` if not already present (collision shape is required for Area3D to detect bodies).
4. **Configure** `AttackArea/CollisionShape3D` mask to layer 2 (in scene file or via code; prefer scene file for visibility).
5. **Add** `Timer` child to `AttackArea` named `CooldownTimer` (if not already in placeholder).
6. **Verify** `attack` action exists in `project.godot` InputMap; if missing, add it as `ui_accept` fallback or new action.
7. **Update** `scripts/player_controller.gd` to call `$AttackArea.attack()` in `_unhandled_input()` when `attack` is pressed.
8. **Validate** scene loads: `godot4 --headless --path . --quit` exits 0.
9. **Run** QA checks per AC mapping table above.

---

## 8. Validation Plan

### Smoke test
```bash
test -f scripts/attack_system.gd
grep -q "class_name AttackSystem" scripts/attack_system.gd
grep -q "collision.mask = 0b100" scripts/attack_system.gd
grep -q "signal hit" scripts/attack_system.gd
grep -q "hit.emit" scripts/attack_system.gd
godot4 --headless --path /home/rowan/womanvshorseVC --quit
echo "EXIT: $?"
```
Expected: all grep pass, `EXIT: 0`.

### QA check commands
| Check | Command |
|---|---|
| AC-1 | `test -f scripts/attack_system.gd && echo PASS || echo FAIL` |
| AC-2 | `grep 'collision.mask' scripts/attack_system.gd` |
| AC-3 | `grep 'Timer' scripts/attack_system.gd && grep 'is_stopped' scripts/attack_system.gd` |
| AC-4 | `grep 'signal hit' scripts/attack_system.gd && grep 'hit.emit' scripts/attack_system.gd` |
| AC-5 | `godot4 --headless --path /home/rowan/womanvshorseVC --quit; echo $?` → 0 |

---

## 9. Risks and Assumptions

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| AttackArea missing collision shape in placeholder | Medium | AC-5 fails (scene won't load) | Check scene file; add CollisionShape3D if missing |
| `attack` input action not in project.godot | Medium | Player cannot trigger attack | Add `attack` action to InputMap during implementation |
| Layer 2 mask value wrong (4 vs 0b100 confusion) | Low | No enemy detection | Verify mask = 4 (binary 100 = layer 2); use explicit decimal `4` to avoid ambiguity |
| Timer node causes double-hit | Low | Enemies take 2x damage | `attack()` guards with `is_stopped()` check; signal fires once per timer start |

**Assumptions**:
- SETUP-002's `AttackArea` placeholder already has a CollisionShape3D child with a valid shape ( CapsuleShape3D or similar).
- `project.godot` has an `attack` input action defined or can accept a new one without conflict.

---

## 10. Blockers

| Blocker | Status |
|---|---|
| Bootstrap: environment must be ready | None — bootstrap completed for SETUP-002 |
| SETUP-002 dependency | ✅ Done and trusted |
| AttackArea placeholder missing CollisionShape3D | **Decision required**: inspect `scenes/player/player.tscn` before implementation begins |

---

## 11. Ticket State After Planning

- Stage: `plan_review` → awaiting approval before `implementation`
- Status: `todo` → `plan_review`  
- No plan approval yet; `approved_plan` remains `false` until review completes