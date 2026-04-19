extends Node3D

## Enemy hit-flash feedback — flashes the node red then white.

@export var flash_duration: float = 0.15

func flash() -> void:
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color.RED, flash_duration)
	tween.tween_property(self, "modulate", Color.WHITE, flash_duration)