extends Area2D
signal moved(direction: Vector2)

@export var base_path: NodePath
@export var nub_path: NodePath

var _base: Panel
var _nub: Panel
var _nub_offset: Vector2 = Vector2.ZERO
var _tracking: bool = false

func _ready() -> void:
	if base_path:
		_base = get_node(base_path) as Panel
	if nub_path:
		_nub = get_node(nub_path) as Panel
	$Nub.position = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			var pos = event.position
			if _is_in_joystick_area(pos):
				_tracking = true
				_update_nub_position(pos)
		elif _tracking:
			_tracking = false
			_nub_offset = Vector2.ZERO
			if _nub:
				_nub.position = Vector2.ZERO
			moved.emit(Vector2.ZERO)

func _is_in_joystick_area(pos: Vector2) -> bool:
	var global_pos = global_position
	return global_pos.distance_to(pos) < 60.0

func _update_nub_position(touch_pos: Vector2) -> void:
	var center = global_position
	var offset = touch_pos - center
	var max_dist = 30.0
	_nub_offset = offset.limit_length(max_dist)
	if _nub:
		_nub.position = _nub_offset
	moved.emit(_nub_offset / max_dist)