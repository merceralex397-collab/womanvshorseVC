extends Area3D

signal hit(enemy: Node3D)

@export var cooldown_time: float = 0.5

@onready var _timer: Timer = $Timer


func _ready() -> void:
	collision.mask = 0b100  # layer 2 — enemy detection
	_body_entered.connect(_on_body_entered)
	_timer.timeout.connect(_on_timer_timeout)
	hit.connect(_on_hit_audio)  # wire procedural SFX


func attack() -> void:
	if _timer.is_stopped():
		# Signal is emitted via _on_body_entered when enemy is in range
		_timer.start(cooldown_time)


func _on_body_entered(body: Node3D) -> void:
	hit.emit(body)


func _on_timer_timeout() -> void:
	pass  # Cooldown complete, ready to attack again

func _on_hit_audio(_enemy: Node3D) -> void:
	AudioManager.play_attack()
