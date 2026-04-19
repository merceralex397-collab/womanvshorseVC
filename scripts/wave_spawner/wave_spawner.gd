class_name WaveSpawner
extends Node3D

## Emitted when a wave begins, passes wave index (1-based) and enemy count.
signal wave_started(wave_index: int, enemy_count: int)

## Emitted when all enemies in the current wave are dead.
signal wave_cleared(wave_index: int)

## Emitted after wave 5 is cleared.
signal all_waves_complete()

## Current wave number (1-based).
var current_wave: int = 0

## Number of enemies still alive in the current wave.
var alive_enemies: int = 0

var _state: State = State.IDLE

enum State { IDLE, SPAWNING, WAVE_ACTIVE, WAVE_CLEARED, ALL_COMPLETE }

## 5-wave progressive difficulty with variant type per wave.
## Each entry: { count, speed, max_health, spawn_radius, variant }
@export var wave_configs: Array[Dictionary] = [
	{ count = 3, speed = 2.0,  max_health = 60.0,  spawn_radius = 9.0,  variant = "brown" },
	{ count = 3, speed = 2.5,  max_health = 80.0,  spawn_radius = 9.5,  variant = "brown" },
	{ count = 4, speed = 3.0,  max_health = 100.0, spawn_radius = 10.0, variant = "black" },
	{ count = 5, speed = 3.5,  max_health = 120.0, spawn_radius = 10.5, variant = "war"   },
	{ count = 5, speed = 4.0,  max_health = 150.0, spawn_radius = 11.0, variant = "boss"  },
]

## Arena boundary for edge spawning (±10 units from Camera3D size=10).
## Spawn positions clamped to ±(spawn_radius) on X and Z.
const ARENA_BOUND: float = 10.0

## Enemy scene reference — set via inspector.
## Must be a PackedScene so we can call scene.instantiate().
@export var enemy_scene: PackedScene

## Optional: Player position reference for NavigationAgent3D target.
## Set by whoever owns the player.
@export var player_ref: Node3D

## Container for active enemy instances (set from arena EnemyContainer).
var _enemy_container: Node3D

@onready var SpawnTimer: Timer = $SpawnTimer

func _ready() -> void:
	SpawnTimer.timeout.connect(_on_spawn_timer_timeout)
	# Resolve enemy container from arena via "arena" group
	var arena = get_tree().get_first_node_in_group("arena")
	if arena:
		var container = arena.get_node_or_null("EnemyContainer")
		if container is Node3D:
			_enemy_container = container
	# If still null, fall back to self as container (for test scenes)
	if _enemy_container == null:
		_enemy_container = self
	wave_cleared.connect(_on_wave_cleared_audio)

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
	var config: Dictionary = wave_configs[current_wave - 1]
	var count: int = config["count"]
	var speed: float = config["speed"]
	var health: float = config["max_health"]
	var radius: float = config["spawn_radius"]
	var variant: String = config.get("variant", "brown")

	wave_started.emit(current_wave, count)

	for i in range(count):
		var spawn_pos: Vector3 = _random_arena_edge_position(radius)
		_spawn_enemy(spawn_pos, speed, health, variant)

	alive_enemies = count
	_state = State.WAVE_ACTIVE

## Instantiate one enemy at spawn_pos and apply per-wave stats + variant model.
## Option A timing (BLOCKER-1 resolution):
##   1. add_child(enemy) → _ready() fires (NO GLB loading — load_variant_model() not in _ready())
##   2. enemy.variant_name = variant → set FIRST
##   3. enemy.speed = speed
##   4. enemy.max_health = health
##   5. enemy.load_variant_model() → GLB loads with correct variant_name
func _spawn_enemy(spawn_pos: Vector3, speed: float, health: float, variant: String) -> void:
	if not enemy_scene:
		push_error("WaveSpawner: enemy_scene not set!")
		return

	var enemy: Node3D = enemy_scene.instantiate()

	# Step 1: add_child first — _ready() fires here (no GLB loading happens)
	_enemy_container.add_child(enemy)
	enemy.global_position = spawn_pos

	# Step 2: set variant_name FIRST — before load_variant_model() is called
	if "variant_name" in enemy:
		enemy.variant_name = variant

	# Step 3-4: Apply per-wave stats
	if "speed" in enemy:
		enemy.speed = speed
	if "max_health" in enemy:
		enemy.max_health = health
		# Also sync Health component's max_health
		var health_node: Node = enemy.get_node_or_null("Health")
		if health_node and "max_health" in health_node:
			health_node.max_health = health

	# Wire died signal — HorseBase.died is emitted when health reaches 0
	if enemy.has_signal("died"):
		enemy.died.connect(_on_enemy_died)

	# Also wire HealthComponent.died in case HorseBase doesn't relay it
	var health_component: Node = enemy.get_node_or_null("Health")
	if health_component and health_component.has_signal("died"):
		if not enemy.has_signal("died"):
			health_component.died.connect(_on_enemy_died)

	# Step 5: NOW load the GLB model — variant_name is already set correctly
	if "load_variant_model" in enemy:
		enemy.load_variant_model()

	# Set navigation target to player
	if player_ref and enemy.has_method("set_navigation_target"):
		enemy.set_navigation_target(player_ref.global_position)

func _on_enemy_died() -> void:
	alive_enemies -= 1
	if alive_enemies <= 0 and _state == State.WAVE_ACTIVE:
		_state = State.WAVE_CLEARED
		wave_cleared.emit(current_wave)
		SpawnTimer.start(2.0)  # 2-second gap before next wave

func _on_wave_cleared_audio(_wave_index: int) -> void:
	AudioManager.play_wave_complete()

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
