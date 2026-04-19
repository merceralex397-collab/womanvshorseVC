extends Control

## 0 = game over, 1 = victory
@export var victory: bool = false
@export var final_score: int = 0
@export var wave_reached: int = 1

@onready var result_label: Label = $CenterContainer/VBoxContainer/ResultLabel
@onready var score_label: Label = $CenterContainer/VBoxContainer/ScoreLabel
@onready var wave_label: Label = $CenterContainer/VBoxContainer/WaveLabel
@onready var play_again_button: Button = $CenterContainer/VBoxContainer/PlayAgainButton
@onready var main_menu_button: Button = $CenterContainer/VBoxContainer/MainMenuButton

func _ready():
	result_label.text = "VICTORY!" if victory else "GAME OVER"
	score_label.text = "Score: %d" % final_score
	wave_label.text = "Wave: %d" % wave_reached
	play_again_button.pressed.connect(_on_play_again)
	main_menu_button.pressed.connect(_on_main_menu)
	AudioManager.play_jingle(victory)

func _on_play_again():
	get_tree().change_scene_to_file("res://scenes/arena/arena.tscn")

func _on_main_menu():
	get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
