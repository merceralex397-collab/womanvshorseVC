# Review: CORE-003 — Wave Spawner (3D Positions)

## Verdict: **APPROVE**

## Evidence Summary

All 5 acceptance criteria are mapped to verifiable evidence in the plan artifact. No blocking defects found.

---

## AC Mapping — Detailed Findings

| AC | Criterion | Plan Evidence | Status |
|---|---|---|---|
| AC-1 | `wave_spawner.gd` exists | Plan §2 specifies `scripts/wave_spawner/wave_spawner.gd`; §8 step 5 creates the file | **PASS** |
| AC-2 | Spawns at randomized arena edge positions | `_random_arena_edge_position()` (§4, lines 159–169): 4-edge selection via `randi() % 4`; `randf_range(-radius, radius)` on perpendicular axis; Y=0.0 floor-level; spawn_radius 9.0–11.0 stays within ARENA_BOUND ±10 from Camera3D size=10 | **PASS** |
| AC-3 | At least 5 waves with progressive difficulty | `wave_configs` Array (§4 lines 52–58): 5 entries with count 3→5, speed 2.0→4.0, max_health 60→150, spawn_radius 9.0→11.0 | **PASS** |
| AC-4 | Signals wave_started, wave_cleared, all_waves_complete | All 3 declared as `signal` (§4 lines 35, 38, 41); state machine emits them on correct transitions | **PASS** |
| AC-5 | Scene loads without errors | V-8: `godot --headless --path . --quit` exit code 0 | **PASS** |

---

## Dependency Verification (CORE-002 — trusted, closeout)

| Dependency | Evidence | Status |
|---|---|---|
| `died` signal on HorseBase | horse_base.gd line 5: `signal died()` — confirmed present | **PASS** |
| `set_navigation_target(pos)` method | horse_base.gd line 36: `func set_navigation_target(pos: Vector3)` — confirmed present | **PASS** |
| XZ-plane movement | horse_base.gd lines 30–31: `velocity.x`, `velocity.z` set; `velocity.y = 0.0` — confirmed | **PASS** |
| 4 exported stats | horse_base.gd lines 8–11: `speed`, `max_health`, `contact_damage`, `score_value` | **PASS** |
| EnemyContainer in arena | arena.tscn line 23: `[node name="EnemyContainer" type="Node3D" parent="Arena"]` — confirmed | **PASS** |

---

## Script Design Quality

### Correct ✓
- State machine enum with 5 states: `IDLE, SPAWNING, WAVE_ACTIVE, WAVE_CLEARED, ALL_COMPLETE`
- `wave_configs` is an `Array[Dictionary]` — Godot 4.x compatible
- `SpawnTimer` `one_shot = true` with 2.0s gap between waves
- `alive_enemies <= 0 AND _state == WAVE_ACTIVE` double-guard prevents double-fire on `wave_cleared`
- `randi() % 4` edge selection + `randf_range(-radius, radius)` on perpendicular axis — correct XZ randomization
- Y=0.0 on all spawn positions — matches XZ-plane movement of player and horses
- `spawn_radius` per-wave (9.0→11.0) stays within arena ±10 bounds

### Advisory Note (non-blocking) ⚠
- `horse_base.gd` does **not** expose `set_speed()` or `set_max_health()` methods. The plan's `_spawn_enemy()` calls `enemy.set_speed(speed)` and `enemy.set_max_health(health)` (lines 132–135), but these methods do not exist on HorseBase. Instead, the exported vars `speed` and `max_health` should be set directly on the instantiated node:
  ```gdscript
  enemy.speed = speed
  enemy.max_health = health
  ```
  This is a correctable implementation step, not a plan defect. The implementation must use direct property assignment.

### Advisory Note (non-blocking) ⚠
- `wave_configs` entries accessed via `config["count"]`, `config["speed"]` etc. — safe given the explicit Dictionary keys in the plan. Minor style: typed `Dictionary` access via `.get()` with defaults would be more defensive.

---

## Risk Register Assessment

| Risk | Plan Mitigation | Assessment |
|---|---|---|
| `enemy_scene` not set | `@export var enemy_scene: PackedScene` with `push_error` guard | **Mitigated** |
| `_enemy_container` unresolved | `get_node_or_null` in `_ready` with fallback to `get_tree().root` | **Mitigated** |
| `alive_enemies` counter race | `wave_cleared` fires only when `alive_enemies <= 0 AND _state == WAVE_ACTIVE` | **Mitigated** |
| `died` signal not emitted by HorseBase | CORE-002 QA verified; `if not enemy.has_signal("died")` guard in plan | **Mitigated** |
| NavigationServer not baked | HorseBase uses `move_and_slide` with fallback to stationary if nav missing | **Mitigated** |
| Spawn positions off-arena | `spawn_radius` 9.0–11.0 within ARENA_BOUND ±10 | **Mitigated** |

---

## Zero Blockers

- CORE-002 (horse_base.gd) is done/trusted — `died` signal, `set_navigation_target`, and 4 exported stats confirmed
- SETUP-001 arena scene is done/trusted — `EnemyContainer` Node3D confirmed at arena.tscn line 23
- No unresolved dependencies
- Bootstrap is `ready` per workflow state

---

## Findings

1. **All 5 ACs mapped to verifiable evidence** — each AC has explicit plan text that can be checked in implementation
2. **CORE-002 dependency fully verified** — `died` signal and `set_navigation_target()` confirmed in horse_base.gd
3. **EnemyContainer reference verified** — arena.tscn has `[node name="EnemyContainer" type="Node3D" parent="Arena"]` (line 23)
4. **Camera3D size=10 confirmed** — arena.tscn line 16: `size = 10.0`; plan's `ARENA_BOUND: float = 10.0` matches
5. **Advisory**: `set_speed()`/`set_max_health()` method calls in plan need to be replaced with direct property assignment at implementation time — not a plan defect, correctable in implementation step
6. **No blocking defects** — plan is sound for Godot 4.6

---

## Required Revisions

None. Plan is APPROVED as-is.

---

## Validation Gaps

None. All ACs have explicit checkable plan text. All dependencies verified against current registered artifacts.

---

## Blockers

None.
