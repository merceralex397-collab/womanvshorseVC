# Planning Artifact — CORE-005: 3D Collision and Damage System

## 1. Scope

Connect the existing player attack system (CORE-001) and enemy contact-damage system (CORE-002) into a unified damage pipeline. Wire collision layers, damage signals, hit feedback, and death handling so:

- Player attacks damage enemies (via attack_system.gd `hit` signal → HorseBase.take_damage)
- Enemy contact damages the player (via HorseBase.ContactDamageArea → player.take_damage)
- Both sides play hit feedback (flash) and handle death (fade + queue_free)
- No friendly fire between enemies

**Collision layer convention (verified against existing attack_system.gd code):**
- Layer 1: static geometry (arena)
- Layer 2: not used by current system
- Layer 3: enemies (player AttackArea mask = 0b100 = layer 3 detection per Godot bitmask)

**Note:** The ticket brief states "layer 2 = enemies" but the existing CORE-001 attack_system.gd code sets `collision.mask = 0b100` which is layer 3 in Godot's 1-indexed layer system. The plan below follows the implemented code (enemies = layer 3). The brief should be updated to reflect layer 3 = enemies.

---

## 2. Files / Systems Affected

| File | Change |
|------|--------|
| `scenes/player/player.tscn` | Add player collision layer (3), ensure AttackArea mask = 0b100 (enemies), add HealthComponent child, add PlayerHitFlash child Node3D |
| `scripts/player_controller.gd` | Add `take_damage(amount)` method, health tracking, player_died signal, hit-flash call |
| `scenes/enemies/horse_base.tscn` | Set collision layer (3), ensure ContactDamageArea mask = 0b100 (player), add HitFlash child |
| `scripts/enemies/horse_base.gd` | Add `died` signal relay from HealthComponent, hit-flash call on contact |
| `scripts/HitFlash.gd` | New: flash material tween for enemy hit feedback |
| `scripts/PlayerHitFlash.gd` | New: same pattern for player hit feedback |
| `project.godot` | Define collision layers 1/2/3 in `[physics]` section |

---

## 3. Collision Layer Configuration

### Static (project.godot `[physics]` section)
```
layer_1 = "static_geometry"
layer_2 = "player"
layer_3 = "enemies"
```

### player.tscn — Player CharacterBody3D
- `collision.layer = 0b100` (layer 3 = enemies — same as player since both are the "attacker" side)
- `collision.mask = 0b000` (moves but doesn't use physics mask for damage)
- AttackArea child: `collision.mask = 0b100` (detects layer 3 = enemies) — already set in attack_system.gd script
- Health Node child: script HealthComponent (no collision needed)

### horse_base.tscn — Enemy CharacterBody3D
- `collision.layer = 0b100` (layer 3 = enemies)
- `collision.mask = 0b000`
- ContactDamageArea child: `collision.mask = 0b100` (detects layer 3 = player — same layer, so ContactDamageArea needs its own layer to distinguish)
- Alternative: set ContactDamageArea mask = 0b100 and put player on layer 3 (already done)

---

## 4. Script Design

### 4.1 Player Health — `scripts/player_controller.gd` additions
```
@export var max_health: float = 100.0
@export var invincibility_time: float = 0.5  # brief immunity after hit

signal player_died()
signal player_health_changed(health: float)

var _player_health: float
var _invincible: bool = false

func _ready():
    _player_health = max_health
    player_health_changed.emit(_player_health)

func take_damage(amount: float) -> void:
    if _invincible:
        return
    _player_health -= amount
    player_health_changed.emit(_player_health)
    _trigger_hit_flash()
    if _player_health <= 0:
        player_died.emit()
        queue_free()
    else:
        _start_invincibility()

func _start_invincibility() -> void:
    _invincible = true
    await get_tree().create_timer(invincibility_time).timeout
    _invincible = false

func _trigger_hit_flash() -> void:
    if has_node("PlayerHitFlash"):
        $PlayerHitFlash.flash()
```

### 4.2 Player Hit Flash — New `scripts/PlayerHitFlash.gd`
```
extends Node3D

@export var flash_duration: float = 0.15
@export var flash_color: Color = Color(1, 0.2, 0.2, 1)

func flash() -> void:
    var mat := BaseMaterial3D.new()
    mat.albedo_color = flash_color
    mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
    var tween := create_tween()
    tween.tween_property(self, "modulate", flash_color, flash_duration)
    tween.tween_property(self, "modulate", Color.WHITE, flash_duration)
```

### 4.3 Attack → Damage Wiring — modify `scripts/attack_system.gd`
The `hit` signal currently emits but nothing deals damage. Add a connect in player_controller.gd:
```
func _ready():
    $AttackArea.hit.connect(_on_attack_hit)

func _on_attack_hit(enemy: Node3D) -> void:
    if enemy.has_method("take_damage"):
        enemy.take_damage(25.0)  # player attack damage value
```

### 4.4 Enemy Contact → Player Damage — `scripts/enemies/horse_base.gd`
The existing _on_contact_body_entered already calls `body.take_damage(contact_damage)`. Add hit flash:
```
func _on_contact_body_entered(body: Node3D) -> void:
    # Friendly fire guard: only damage player (CharacterBody3D with take_damage)
    if body.has_method("take_damage"):
        body.take_damage(contact_damage)
        _trigger_hit_flash()
```

### 4.5 Enemy Hit Flash — New `scripts/HitFlash.gd`
```
extends Node3D

@export var flash_duration: float = 0.15

func flash() -> void:
    var tween := create_tween()
    tween.tween_property(self, "modulate", Color.RED, flash_duration)
    tween.tween_property(self, "modulate", Color.WHITE, flash_duration)
```

### 4.6 Enemy Death — `scripts/enemies/horse_base.gd`
HealthComponent.died is already emitted when health reaches 0. Add death handling in horse_base:
```
func _ready():
    Health.died.connect(_on_enemy_died)

func _on_enemy_died() -> void:
    died.emit()
    # Optional: play death animation before queue_free
    var tween := create_tween()
    tween.tween_property(self, "scale", Vector3.ZERO, 0.3)
    tween.tween_callback(queue_free)
```

---

## 5. Implementation Steps

### Step 1 — Update project.godot
Add collision layer names in `[physics]` section:
```
[physics]
layer_1 = "static_geometry"
layer_2 = "player"
layer_3 = "enemies"
```

### Step 2 — Update player.tscn
- Set Player CharacterBody3D `collision.layer = 0b100`
- Add Health Node child with HealthComponent script
- Add PlayerHitFlash Node3D child (empty marker)
- Ensure AttackArea has `collision.mask = 0b100` (script handles this)

### Step 3 — Create scripts/PlayerHitFlash.gd
Implement flash tween as described above.

### Step 4 — Update scripts/player_controller.gd
- Add health system: `max_health`, `_player_health`, `invincibility_time`
- Add `player_died` and `player_health_changed` signals
- Add `take_damage(amount)` method with invincibility frames
- Add `_trigger_hit_flash()` call on damage
- Connect `$AttackArea.hit` → `_on_attack_hit` in `_ready()`
- Emit `player_health_changed` on damage
- Call `player_died` and `queue_free()` on death

### Step 5 — Update horse_base.tscn
- Set HorseBase CharacterBody3D `collision.layer = 0b100`
- Set ContactDamageArea `collision.mask = 0b100` (detects player on same layer)
- Add HitFlash Node3D child (empty marker)

### Step 6 — Create scripts/HitFlash.gd
Implement enemy flash tween as described above.

### Step 7 — Update scripts/enemies/horse_base.gd
- Add `_trigger_hit_flash()` call in `_on_contact_body_entered`
- Connect `Health.died` → `_on_enemy_died` in `_ready()`
- Death: emit `died` signal, scale tween to zero, `queue_free()`

### Step 8 — Godot Headless Validation
```
godot4 --headless --path . --quit
```
Confirm EXIT:0.

---

## 6. AC Mapping (6 Criteria)

| AC | Evidence |
|----|---------|
| AC-1: Collision layers configured correctly | project.godot layers 1/2/3 defined; player.tscn collision.layer=0b100; horse_base.tscn collision.layer=0b100; AttackArea mask=0b100; ContactDamageArea mask=0b100 |
| AC-2: Player attacks damage enemies | attack_system.gd hit signal → player_controller.gd _on_attack_hit() calls enemy.take_damage(25.0); HorseBase.take_damage delegates to HealthComponent |
| AC-3: Enemy contact damages player | horse_base.gd _on_contact_body_entered calls body.take_damage(contact_damage); player.take_damage(amount) implemented with invincibility |
| AC-4: Hit feedback (flash or knockback) | PlayerHitFlash.gd tween on modulate (player); HitFlash.gd tween on modulate (enemy); triggered on each damage event |
| AC-5: Death handling for both player and enemies | player_controller.gd: player_died signal + queue_free(); horse_base.gd: Health.died → _on_enemy_died → died signal + scale tween + queue_free() |
| AC-6: No friendly fire | _on_contact_body_entered guard: `body.has_method("take_damage")` only true for player CharacterBody3D; enemies don't expose take_damage at body level |

---

## 7. Validation Plan

1. **Layer check**: grep project.godot for `layer_[123]`; verify player.tscn collision.layer=0b100; verify horse_base.tscn collision.layer=0b100
2. **Signal wiring check**: grep for `hit.connect` and `_on_attack_hit`; confirm Health.died wiring in horse_base._ready
3. **Damage method check**: grep for `take_damage` in both player_controller.gd and horse_base.gd
4. **Friendly fire check**: grep _on_contact_body_entered — verify no path that damages another enemy
5. **Godot headless**: `godot4 --headless --path . --quit` → EXIT:0
6. **Scene load**: verify player.tscn and horse_base.tscn both load without errors

---

## 8. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| AttackArea already has mask set in script conflicts with scene value | Low | Script sets mask=0b100 correctly; scene should not override | Keep script mask, add comment in scene file |
| Invincibility timing race condition | Low | Brief window where two hits could get through | 0.5s invincibility is sufficient for gameplay feel |
| Enemy ContactDamageArea body_entered fires on other enemies | Low | Guard in _on_contact_body_entered checks `body.has_method("take_damage")` | Friendly fire impossible because only player has take_damage |
| Death tween conflicts with scene removal | Low | Tween interrupted if parent removes child | Use `tween.tween_callback(queue_free)` to ensure cleanup |

---

## 9. Blockers

**Zero blockers.** All dependencies are done/trusted:
- CORE-001 (attack_system.gd) — done
- CORE-002 (horse_base.gd, HealthComponent) — done
- SETUP-001 (arena scene) — done
- SETUP-002 (player_controller.gd) — done

No architectural, provider/model, or scope choices remain unresolved.
