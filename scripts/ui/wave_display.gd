extends VBoxContainer
class_name WaveDisplay

## Displays current wave number and enemy count.
## Attached to WaveContainer per plan CORE-004.
## Wiring to WaveSpawner signals deferred to CORE-005.

signal wave_updated(wave_num: int)
signal enemies_updated(count: int)

@export var wave_spawner_path: NodePath

var _wave_label: Label
var _enemy_count_label: Label

func _ready() -> void:
	_wave_label = $WaveLabel
	_enemy_count_label = $EnemyCountLabel
	
	if wave_spawner_path:
		var spawner = get_node_or_null(wave_spawner_path)
		if spawner:
			if spawner.has_signal("wave_started"):
				spawner.connect("wave_started", _on_wave_started)
			if spawner.has_signal("wave_cleared"):
				spawner.connect("wave_cleared", _on_wave_cleared)
			if spawner.has_signal("enemy_spawned"):
				spawner.connect("enemy_spawned", _on_enemy_spawned)
			if spawner.has_signal("enemy_died"):
				spawner.connect("enemy_died", _on_enemy_died)
			# Initial values
			if "current_wave" in spawner:
				update_display(spawner.current_wave, 0)
			if "alive_enemies" in spawner:
				update_display(1, spawner.alive_enemies)
		else:
			push_warning("[WaveDisplay] wave_spawner_path node not found: " + str(wave_spawner_path))
	else:
		update_display(1, 0)

func _on_wave_started(wave_number: int) -> void:
	update_display(wave_number, 0)

func _on_wave_cleared(wave_number: int) -> void:
	pass

func _on_enemy_spawned(enemy) -> void:
	if _enemy_count_label:
		var current = int(_enemy_count_label.text.replace("Enemies: ", "").strip_edges())
		update_display(get_current_wave(), current + 1)

func _on_enemy_died(enemy) -> void:
	if _enemy_count_label:
		var current = int(_enemy_count_label.text.replace("Enemies: ", "").strip_edges())
		update_display(get_current_wave(), max(0, current - 1))

func get_current_wave() -> int:
	if _wave_label:
		var text = _wave_label.text
		var parts = text.split(" ")
		if parts.size() >= 2:
			return parts[1].to_int()
	return 1

func update_display(wave: int, enemies_remaining: int) -> void:
	if _wave_label:
		_wave_label.text = "Wave %d" % wave
	if _enemy_count_label:
		_enemy_count_label.text = "Enemies: %d" % enemies_remaining
	wave_updated.emit(wave)
	enemies_updated.emit(enemies_remaining)
