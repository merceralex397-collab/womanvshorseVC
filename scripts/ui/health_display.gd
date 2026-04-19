extends HBoxContainer
class_name HealthDisplay

## Displays player health bar and label.
## Attached to HealthContainer per plan CORE-004.
## Wiring to actual player health deferred to CORE-005.

signal health_changed(current: int, maximum: int)

@export var player_path: NodePath = NodePath("../../Player")

var _health_bar: ProgressBar
var _health_label: Label

func _ready() -> void:
	_health_label = $HealthLabel
	_health_bar = $HealthBar
	
	if player_path:
		var player = get_node_or_null(player_path)
		if player and player.has_signal("health_changed"):
			player.connect("health_changed", _on_health_changed)
		elif player and "health" in player:
			var health_val = player.health if "health" in player else 100
			var max_val = player.max_health if "max_health" in player else 100
			update_health(health_val, max_val)
		else:
			push_warning("[HealthDisplay] player node not found or has no health signal: " + str(player_path))
	else:
		update_health(100, 100)

func _on_health_changed(current: int, maximum: int) -> void:
	update_health(current, maximum)

func update_health(current: int, maximum: int) -> void:
	if _health_bar:
		_health_bar.max_value = maximum
		_health_bar.value = current
	if _health_label:
		_health_label.text = "HP: %d/%d" % [current, maximum]
	health_changed.emit(current, maximum)
