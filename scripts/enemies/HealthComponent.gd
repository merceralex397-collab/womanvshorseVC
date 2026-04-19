extends Node

## Lightweight health component.
## Attach to a child Node named "Health" under the enemy body.

signal died()

@export var max_health: float = 100.0

var current_health: float

func _ready() -> void:
	current_health = max_health

## Apply damage. Returns true if this hit killed the entity.
func take_damage(amount: float) -> bool:
	current_health -= amount
	if current_health <= 0.0:
		died.emit()
		return true
	return false
