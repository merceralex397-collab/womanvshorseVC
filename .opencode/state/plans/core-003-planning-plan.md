# Plan: CORE-003 — Wave Spawner (3D Positions)

## 1. Scope

Create `wave_spawner.gd` and `scenes/wave_spawner/wave_spawner.tscn` that manages a 5-wave progressive difficulty game loop. The spawner instantiates `HorseBase` enemies (from CORE-002) at randomized arena perimeter positions, tracks alive enemy count via the `died` signal, and emits `wave_started`, `wave_cleared`, and `all_waves_complete` signals.

## 2. Files / Systems Affected

| File | Role |
|---|---|
| `scenes/wave_spawner/wave_spawner.tscn` | Wave spawner scene with Node3D root and child Timer |
| `scripts/wave_spawner/wave_spawner.gd` | Wave state machine, spawn logic, alive tracking, signal emissions |
| `scenes/enemies/horse_base.tscn` (existing) | Enemy prefab instantiated on spawn |
| `scripts/enemies/horse_base.gd` (existing) | Confirmed: `set_navigation_target(pos)`, `died` signal, 4 exported stats |

## 3. Scene Structure

```
wave_spawner.tscn
└── WaveSpawner (Node3D)          # root — owns wave state machine
    └── SpawnTimer (Timer)         # one-shot timer between waves (connect to _on_spawn_timer_timeout)
```

**WaveSpawner (Node3D)** — no built-in spatial role; owns all wave logic, enemy tracking, and signal emissions.

**SpawnTimer (Timer)** — `one_shot = true`, `wait_time = 2.0`. Fires after `wave_delay` seconds between waves. Connected to `_on_spawn_timer_timeout()` which advances the state machine.

## 4. Script Design — `wave_spawner.gd`

```gdscript
class_name WaveSpawner
extends Node3D

## Emitted when a wave begins, passes wave index (1-based) and enemy count.
signal wave_started(wave_index: int, enemy_count: int)

## Emitted when all enemies in the current wave are dead.
signal wave_cleared(wave_index: int)

## Emitted after wave 5 is cleared.
signal all_waves_complete()

## Configured from wave_configs dictionary.
var current_wave: int = 0
var alive_enemies: int = 0
var _state: State = State.IDLE

enum State { IDLE, SPAWNING, WAVE_ACTIVE, WAVE_CLEARED, ALL_COMPLETE }

## 5-wave progressive difficulty.
## Each entry: { count: int, speed: float, max_health: float, spawn_radius: float }
@export var wave_configs: Array[Dictionary] = [
    { count = 3, speed = 2.0,  max_health = 60.0,  spawn_radius = 9.0 },
    { count = 3, speed = 2.5,  max_health = 80.0,  spawn_radius = 9.5 },
    { count = 4, speed = 3.0,  max_health = 100.0, spawn_radius = 10.0 },
    { count = 5, speed = 3.5,  max_health = 120.0, spawn_radius = 10.5 },
    { count = 5, speed = 4.0,  max_health = 150.0, spawn_radius = 11.0 },
]

## Arena boundary for edge spawning (±10 units from Camera3D size=10).
## Spawn positions clamped to ±(spawn_radius) on X and Z.
const ARENA_BOUND: float = 10.0

## Enemy scene reference — set via inspector or by finding horse_base.tscn.
## Must be a PackedScene so we can call scene.instantiate().
@export var enemy_scene: PackedScene

## Optional: Player position reference for NavigationAgent3D target.
## Set by whoever owns the player. Used to set each enemy's nav target after spawn.
@export var player_ref: Node3D

## Container for active enemy instances.
var _enemy_container: Node3D  # set via arena.tscn EnemyContainer reference

@onready var SpawnTimer: Timer = $SpawnTimer

func _ready() -> void:
    SpawnTimer.timeout.connect(_on_spawn_timer_timeout)
    # Initialize enemy container reference from arena if available
    var arena = get_tree().get_first_node_in_group("arena")
    if arena:
        var container = arena.get_node_or_null("EnemyContainer")
        if container is Node3D:
            _enemy_container = container

## Starts the wave loop. Call this from game manager or HUD.
func start_waves() -> void:
    current_wave = 0
    _state = State.IDLE
    _advance_wave()

## Internal: advance to the next wave or complete.
func _advance_wave() -> void:
    current_wave += 1
    if current_wave > wave_configs.size():
        _state = State.ALL_COMPLETE
        all_waves_complete.emit()
        return

    _state = State.SPAWNING
    _spawn_wave()

## Spawn all enemies for the current wave.
func _spawn_wave() -> void:
    var config = wave_configs[current_wave - 1]
    var count: int = config["count"]
    var speed: float = config["speed"]
    var health: float = config["max_health"]
    var radius: float = config["spawn_radius"]

    wave_started.emit(current_wave, count)

    for i in range(count):
        var spawn_pos: Vector3 = _random_arena_edge_position(radius)
        _spawn_enemy(spawn_pos, speed, health)

    alive_enemies = count
    _state = State.WAVE_ACTIVE
    SpawnTimer.start(config.get("delay", 0.0))

## Instantiate one enemy at spawn_pos and apply per-wave stats.
func _spawn_enemy(spawn_pos: Vector3, speed: float, health: float) -> void:
    if not enemy_scene:
        push_error("WaveSpawner: enemy_scene not set!")
        return

    var enemy: Node3D = enemy_scene.instantiate()
    _enemy_container.add_child(enemy)
    enemy.global_position = spawn_pos

    # Configure per-wave stats
    if enemy.has_method("set_speed"):
        enemy.set_speed(speed)
    if enemy.has_method("set_max_health"):
        enemy.set_max_health(health)

    # Wire died signal
    if enemy.has_signal("died"):
        enemy.died.connect(_on_enemy_died)

    # Set navigation target to player
    if player_ref and enemy.has_method("set_navigation_target"):
        enemy.set_navigation_target(player_ref.global_position)

func _on_enemy_died() -> void:
    alive_enemies -= 1
    if alive_enemies <= 0 and _state == State.WAVE_ACTIVE:
        _state = State.WAVE_CLEARED
        wave_cleared.emit(current_wave)
        SpawnTimer.start(2.0)  # 2-second gap before next wave

func _on_spawn_timer_timeout() -> void:
    if _state == State.WAVE_CLEARED:
        _advance_wave()
    elif _state == State.SPAWNING:
        # Safety: if timer fires during spawn, just transition to active
        _state = State.WAVE_ACTIVE

## Returns a random 3D position on the arena perimeter, clamped to radius.
func _random_arena_edge_position(radius: float) -> Vector3:
    var edge: int = randi() % 4
    var rx: float = randf_range(-radius, radius)
    var rz: float = randf_range(-radius, radius)
    match edge:
        0: return Vector3( radius, 0.0, rz)   # east edge
        1: return Vector3(-radius, 0.0, rz)   # west edge
        2: return Vector3(rx,  0.0, radius)   # north edge
        3: return Vector3(rx,  0.0,-radius)   # south edge
    return Vector3(radius, 0.0, 0.0)
```

### Wave State Machine

```
IDLE → (start_waves) → SPAWNING → (all spawned) → WAVE_ACTIVE
WAVE_ACTIVE → (alive == 0) → WAVE_CLEARED → (timer) → SPAWNING → ...
WAVE_CLEARED → (wave 5 done) → ALL_COMPLETE → all_waves_complete signal
```

### Progressive Difficulty Table

| Wave | Enemy Count | Speed | Max Health | Spawn Radius | Notes |
|---|---|---|---|---|---|
| 1 | 3 | 2.0 | 60.0 | 9.0 | Tutorial pace |
| 2 | 3 | 2.5 | 80.0 | 9.5 | Slightly faster |
| 3 | 4 | 3.0 | 100.0 | 10.0 | More enemies |
| 4 | 5 | 3.5 | 120.0 | 10.5 | Swarm |
| 5 | 5 | 4.0 | 150.0 | 11.0 | Boss-level HP |

All enemies share the same variant type in this ticket (model swapping handled by CORE-006).

## 5. Arena Edge Position Randomization

- Arena bounds: **±10 units** in X and Z (from SETUP-001 Camera3D `size=10` with orthographic projection)
- **4 edges**: east (+X), west (-X), north (+Z), south (-Z)
- Random point selected on chosen edge with `randf_range(-radius, radius)` on the perpendicular axis
- Y stays at `0.0` (arena floor level, matching player and horse XZ-plane movement)
- `spawn_radius` in each wave config allows progressive push outward from 9.0 to 11.0 — stays within arena bounds

## 6. Signal Wiring — `HorseBase.died` → WaveSpawner Counter

```gdscript
# In _spawn_enemy():
enemy.died.connect(_on_enemy_died)

# Handler:
func _on_enemy_died() -> void:
    alive_enemies -= 1
    if alive_enemies <= 0 and _state == State.WAVE_ACTIVE:
        _state = State.WAVE_CLEARED
        wave_cleared.emit(current_wave)
        SpawnTimer.start(2.0)
```

- Callable-based `.connect()` is Godot 4.x idiomatic for type-safe signal wiring
- Each spawned `HorseBase` instance has its own `died` signal; wiring is per-instance
- `alive_enemies` counter decremented atomically on each `died` emission
- `wave_cleared` only fires when the counter reaches 0 while the state is `WAVE_ACTIVE` (guards against double-fire)

## 7. AC Mapping Table

| # | Acceptance Criterion | Evidence Type |
|---|---|---|
| AC-1 | `wave_spawner.gd` exists | File glob + headless parse |
| AC-2 | Spawns at randomized arena edge positions | `_random_arena_edge_position()` code present; `randi() % 4` selects edge; `randf_range(-radius, radius)` on perpendicular axis; Y=0.0 |
| AC-3 | At least 5 waves with progressive difficulty | `wave_configs` Array with 5 entries; each has count/speed/health/radius; table in plan artifact |
| AC-4 | Signals for `wave_started`, `wave_cleared`, `all_waves_complete` | Script contains all 3 `signal` declarations; state machine transitions emit them |
| AC-5 | Scene loads without errors | `godot --headless --path . --quit` exit code 0 |

## 8. Implementation Steps

1. Create `scenes/wave_spawner/` directory if it does not exist.
2. Create `wave_spawner.tscn` with `Node3D` root named `WaveSpawner`.
3. Add `Timer` child named `SpawnTimer` with `one_shot = true`.
4. Create `scripts/wave_spawner/` directory if it does not exist.
5. Create `wave_spawner.gd` with all exported vars, state machine, signal declarations, `_random_arena_edge_position()`, and `_spawn_enemy()`.
6. Attach `wave_spawner.gd` to the `WaveSpawner` Node3D in the scene.
7. Wire `SpawnTimer.timeout` → `_on_spawn_timer_timeout` via Inspector or `@onready`.
8. Set `enemy_scene` export on WaveSpawner to `res://scenes/enemies/horse_base.tscn`.
9. Verify `_enemy_container` resolves to arena's `EnemyContainer` Node3D via `get_node_or_null`.
10. Save scene and script.
11. Run `godot --headless --path . --quit` to validate load.

## 9. Validation Plan

| Step | Command / Check | Pass Criterion |
|---|---|---|
| V-1 | `ls scripts/wave_spawner/wave_spawner.gd` | file exists |
| V-2 | `ls scenes/wave_spawner/wave_spawner.tscn` | file exists |
| V-3 | `grep "signal wave_started" scripts/wave_spawner/wave_spawner.gd` | present |
| V-4 | `grep "signal wave_cleared" scripts/wave_spawner/wave_spawner.gd` | present |
| V-5 | `grep "signal all_waves_complete" scripts/wave_spawner/wave_spawner.gd` | present |
| V-6 | `grep "_random_arena_edge_position" scripts/wave_spawner/wave_spawner.gd` | present |
| V-7 | `grep -c "wave_configs" scripts/wave_spawner/wave_spawner.gd` | >= 1 |
| V-8 | Godot headless load check | exit code 0 |

## 10. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| `enemy_scene` not set before first `_spawn_enemy` call | medium | high | Export `@export var enemy_scene: PackedScene` with tool-tip; set via Inspector; add `push_error` guard in `_spawn_enemy` |
| `_enemy_container` reference unresolved at spawn time | medium | high | Resolve via `get_node_or_null` in `_ready`; fallback to `get_tree().root` if arena reference missing |
| `alive_enemies` counter races with delayed `died` signals | low | medium | `wave_cleared` only fires when `alive_enemies <= 0 AND _state == WAVE_ACTIVE` — state guard prevents double-fire |
| HorseBase `died` signal not emitted when health reaches 0 | low | high | CORE-002 QA verified `died` signal; still check `if not enemy.has_signal("died")` guard |
| NavigationServer not baked for arena | low | high | SETUP-001 arena scene trusted; spawner sets nav target; enemies use `move_and_slide`; if nav is missing HorseBase falls back to stationary |
| Spawn positions off-arena (beyond ±10 bounds) | low | low | `spawn_radius` clamped to 9.0–11.0; edge selection keeps max extent at ±11; within arena safe zone |

## 11. Blockers

- **None.** CORE-002 (horse_base.gd) is done and trusted. CORE-001 attack system is done. SETUP-001 arena scene is done and provides `EnemyContainer`. No unresolved dependencies.