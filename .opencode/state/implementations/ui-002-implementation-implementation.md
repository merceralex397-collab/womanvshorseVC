# Implementation — UI-002: Game Over Screen

## Files Created / Verified

| File | Status |
|------|--------|
| `scenes/ui/game_over_screen.tscn` | ✓ Already exists (1535 bytes, 54 lines) — Control root with full node hierarchy |
| `scripts/ui/game_over_screen.gd` | ✓ Already exists (25 lines) — victory/score/wave exports + button handlers |

## Godot Headless Validation
```
$ godot4 --headless --path . --quit
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT_CODE=0
```
✓ PASS — scene loads without errors

## AC Verification

### AC-1: game_over_screen.tscn exists with Control root
```
$ grep "type=\"Control\"" scenes/ui/game_over_screen.tscn
node name="GameOverScreen" type="Control"
```
✓ Control root confirmed

### AC-2: Shows Game Over or Victory text
```gdscript
result_label.text = "VICTORY!" if victory else "GAME OVER"
```
✓ Both "GAME OVER" and "VICTORY!" strings present

### AC-3: Displays score and wave reached
```gdscript
score_label.text = "Score: %d" % final_score
wave_label.text = "Wave: %d" % wave_reached
```
✓ ScoreLabel and WaveLabel via @onready in _ready()

### AC-4: Play Again and Main Menu buttons
```gdscript
play_again_button.pressed.connect(_on_play_again)
main_menu_button.pressed.connect(_on_main_menu)
```
✓ Both buttons wired; custom_minimum_size Vector2(200, 64) = 64px height (≥48dp touch-friendly)

### AC-5: Scene loads without errors
✓ Godot v4.6.1 headless EXIT:0

## Node Hierarchy (game_over_screen.tscn)
```
GameOverScreen (Control, anchors_preset=15 fullscreen)
└── CenterContainer (centered, fullscreen anchors)
    └── VBoxContainer (ALIGNMENT_CENTER)
        ├── ResultLabel (Label, font_size=48)
        ├── ScoreLabel  (Label, font_size=32)
        ├── WaveLabel   (Label, font_size=32)
        ├── PlayAgainButton (Button, 200×64px)
        └── MainMenuButton  (Button, 200×64px)
```

## Script Design (game_over_screen.gd)
```gdscript
extends Control

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

func _on_play_again():
    get_tree().change_scene_to_file("res://scenes/arena/arena.tscn")

func _on_main_menu():
    get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
```

## Acceptance Criteria Summary
| AC | Verification | Result |
|----|-------------|--------|
| AC-1: game_over_screen.tscn exists with Control root | grep type="Control" | ✓ PASS |
| AC-2: Shows Game Over or Victory text | grep "GAME OVER"\|"VICTORY!" in script | ✓ PASS |
| AC-3: Displays score and wave reached | @onready + _ready() wired | ✓ PASS |
| AC-4: Play Again and Main Menu buttons | pressed.connect on both, 200×64px | ✓ PASS |
| AC-5: Scene loads without errors | godot4 --headless --quit EXIT:0 | ✓ PASS |

**All 5 ACs PASS. Godot headless EXIT:0.**