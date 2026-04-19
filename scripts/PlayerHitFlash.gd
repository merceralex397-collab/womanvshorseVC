extends Node3D

## Player hit-flash feedback — flashes the node red then white.

@export var flash_duration: float = 0.15
@export var flash_color: Color = Color(1.0, 0.2, 0.2, 1.0)

func flash() -> void:
	var tween := create_tween()
	tween.tween_property(self, "modulate", flash_color, flash_duration)
	tween.tween_property(self, "modulate", Color.WHITE, flash_duration)