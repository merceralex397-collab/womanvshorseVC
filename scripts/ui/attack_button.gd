extends Area2D
signal pressed
signal released

var _pressing: bool = false

func _ready() -> void:
	monitoring = true
	monitorable = true

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		var shape = $AttackCollision.shape as CircleShape2D
		if not shape:
			return
		var radius = shape.radius
		if event.pressed:
			var pos = event.position
			if global_position.distance_to(pos) < radius:
				_pressing = true
				pressed.emit()
		elif _pressing:
			_releasing = false
			released.emit()

var _releasing: bool = false