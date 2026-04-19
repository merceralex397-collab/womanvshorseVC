extends Node
signal score_changed(new_score: int)

@export var score_label_path: NodePath

var _score_label: Label
var _current_score: int = 0

func _ready() -> void:
	if score_label_path:
		_score_label = get_node(score_label_path) as Label
	update_display(0)

func update_score(points: int) -> void:
	_current_score += points
	update_display(_current_score)
	score_changed.emit(_current_score)

func update_display(score: int) -> void:
	if _score_label:
		_score_label.text = "Score: %d" % score

func _on_enemy_killed(score_value: int) -> void:
	update_score(score_value)