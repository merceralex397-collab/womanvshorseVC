extends CharacterBody3D

@export var speed: float = 5.0
@export var gravity: float = -20.0
@export var max_health: float = 100.0
@export var invincibility_time: float = 0.5

signal player_died()
signal player_health_changed(health: float)

var _player_health: float
var _invincible: bool = false

@onready var AttackArea = $AttackArea
@onready var ModelContainer: Node3D = $ModelContainer
@onready var MeshInstance3D: MeshInstance3D = $ModelContainer/MeshInstance3D

func _ready() -> void:
	_player_health = max_health
	player_health_changed.emit(_player_health)
	AttackArea.hit.connect(_on_attack_hit)
	_load_visual_model()

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

	# Handle attack input
	if Input.is_action_just_pressed("attack"):
		$AttackArea.attack()

## Load the woman-warrior GLB model into the ModelContainer/MeshInstance3D child.
## Uses GLTFDocument runtime loading, mirroring the CORE-006 Option A pattern.
func _load_visual_model() -> void:
	var model_path := "res://assets/models/woman-warrior.glb"
	if model_path.is_empty():
		push_warning("PlayerController: no model_path set")
		return

	if not ModelContainer:
		push_warning("PlayerController: ModelContainer node not found")
		return

	if not MeshInstance3D:
		push_warning("PlayerController: MeshInstance3D not found under ModelContainer")
		return

	# Use GLTFDocument to load the GLB at runtime
	var state := GLTFState.new()
	var doc := GLTFDocument.new()
	var result := doc.append_from_file(model_path, state)
	if result != OK:
		push_error("PlayerController: GLTFDocument.append_from_file failed for " + model_path + ", result=" + str(result))
		return

	# Generate mesh from the first mesh in the document
	if state.get_mesh_count() > 0:
		var mesh: Mesh = state.get_mesh(0)
		MeshInstance3D.mesh = mesh
	else:
		push_warning("PlayerController: GLB at " + model_path + " has no meshes")

func take_damage(amount: float) -> void:
	if _invincible:
		return
	_player_health -= amount
	player_health_changed.emit(_player_health)
	_trigger_hit_flash()
	AudioManager.play_hurt()
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

func _on_attack_hit(enemy: Node3D) -> void:
	if enemy.has_method("take_damage"):
		enemy.take_damage(25.0)