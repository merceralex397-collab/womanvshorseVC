class_name HorseBase
extends CharacterBody3D

## Emitted when health reaches zero.
signal died()

## Exported stat defaults — override in subclasses or via inspector per variant.
@export var speed: float = 3.0
@export var max_health: float = 100.0
@export var contact_damage: float = 10.0
@export var score_value: int = 100

## Variant name used to look up GLB model path from HorseVariants.
## Set this BEFORE calling load_variant_model(). Default "brown".
@export var variant_name: String = "brown"

## Internal
var _nav_agent: NavigationAgent3D

@onready var Health: Node = $Health
@onready var ContactDamageArea: Area3D = $ContactDamageArea

func _ready() -> void:
	_nav_agent = $NavigationAgent3D
	_nav_agent.max_speed = speed
	ContactDamageArea.body_entered.connect(_on_contact_body_entered)
	_nav_agent.target_reached.connect(_on_target_reached)
	Health.died.connect(_on_enemy_died)

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

## Load the GLB model for this variant into the ModelContainer/MeshInstance3D child.
## Must be called AFTER the node is added to the scene tree AND after variant_name is set.
## Uses Option A timing: variant_name set BEFORE add_child, this called AFTER.
func load_variant_model() -> void:
	var variant_data: Dictionary = HorseVariants.get_variant(variant_name)
	if variant_data.is_empty():
		push_warning("HorseBase: unknown variant_name '" + variant_name + "', no model loaded")
		return

	var model_path: String = variant_data.get("model_path", "")
	if model_path.is_empty():
		push_warning("HorseBase: variant '" + variant_name + "' has no model_path")
		return

	# Resolve ModelContainer child — created in horse_base.tscn
	var model_container: Node3D = get_node_or_null("ModelContainer")
	if not model_container:
		push_warning("HorseBase: ModelContainer node not found")
		return

	var mesh_instance: MeshInstance3D = model_container.get_node_or_null("MeshInstance3D")
	if not mesh_instance:
		push_warning("HorseBase: MeshInstance3D not found under ModelContainer")
		return

	# Use GLTFDocument to load the GLB at runtime
	var state := GLTFState.new()
	var doc := GLTFDocument.new()
	var result := doc.append_from_file(model_path, state)
	if result != OK:
		push_error("HorseBase: GLTFDocument.append_from_file failed for " + model_path + ", result=" + str(result))
		return

	# Generate mesh from the first mesh in the document
	if state.get_mesh_count() > 0:
		var mesh: Mesh = state.get_mesh(0)
		mesh_instance.mesh = mesh
	else:
		push_warning("HorseBase: GLB at " + model_path + " has no meshes")


## Apply damage to self. Returns true if this hit killed the enemy.
func take_damage(amount: float) -> bool:
	return Health.take_damage(amount)

func _on_contact_body_entered(body: Node3D) -> void:
	# Friendly fire guard: only damages bodies with take_damage (player)
	if body.has_method("take_damage"):
		body.take_damage(contact_damage)
		_trigger_hit_flash()

func _on_enemy_died() -> void:
	AudioManager.play_death()
	died.emit()
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector3.ZERO, 0.3)
	tween.tween_callback(queue_free)

func _trigger_hit_flash() -> void:
	if has_node("HitFlash"):
		$HitFlash.flash()

func _on_target_reached() -> void:
	pass