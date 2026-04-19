# Plan — UI-002: Game Over Screen

## 1. Scope

Create `game_over_screen.tscn` with `game_over_screen.gd` that displays a game-over or victory result screen with final score, wave reached, a "Play Again" button, and a "Main Menu" button. The screen is shown when the player dies (`player_died` signal, CORE-005) or when all waves are cleared (`all_waves_complete` signal, CORE-003).

## 2. Files / Systems Affected

| File | Action |
|------|--------|
| `scenes/ui/game_over_screen.tscn` | Create — Control root scene |
| `scripts/ui/game_over_screen.gd` | Create — button handlers + label population |
| `scenes/arena/arena.tscn` | Modify — wire player_died / all_waves_complete → game_over_screen |
| `scenes/ui/hud.tscn` | Review only — confirms HUD exposes score/wave via GameState or signals |
| `project.godot` | No change expected |

## 3. Scene Structure

```
Control (game_over_screen.tscn)
└── CenterContainer
    └── VBoxContainer
        ├── ResultLabel (Label)          — "GAME OVER" or "VICTORY!"
        ├── ScoreLabel (Label)           — "Score: X"
        ├── WaveLabel (Label)            — "Wave: X"
        ├── PlayAgainButton (Button)     — restarts arena
        └── MainMenuButton (Button)      — returns to title screen
```

- `Control` fill anchors: `ANCHOR_LEFT/TOP/RIGHT/BOTTOM = 0`, `ANCHOR_RIGHT/BOTTOM = 1` for full-screen coverage
- `CenterContainer` centers its child `VBoxContainer`
- `VBoxContainer` uses `ALIGNMENT_CENTER` for vertical centering
- Minimum button height: 64 px (touch-friendly, ≥48 dp per AC)
- Minimum font size: 24 px for labels

## 4. Script Design (`game_over_screen.gd`)

```gdscript
extends Control

## 0 = game over, 1 = victory
@export var victory: bool = false
@export var final_score: int = 0
@export var wave_reached: int = 1

func _ready():
    # Result text
    $CenterContainer/VBoxContainer/ResultLabel.text = "VICTORY!" if victory else "GAME OVER"
    # Score and wave
    $CenterContainer/VBoxContainer/ScoreLabel.text = "Score: %d" % final_score
    $CenterContainer/VBoxContainer/WaveLabel.text = "Wave: %d" % wave_reached
    # Button wiring
    $CenterContainer/VBoxContainer/PlayAgainButton.pressed.connect(_on_play_again)
    $CenterContainer/VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu)

func _on_play_again():
    get_tree().change_scene_to_file("res://scenes/arena/arena.tscn")

func _on_main_menu():
    get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
```

**Signal wiring (arena.tscn):**
- `player_died → game_over_screen.show(victory=false, ...)`
- `all_waves_complete → game_over_screen.show(victory=true, ...)`

**Data passing:**
- Option A (chosen): exported vars set by caller before `change_scene_to_file`
- Fallback: `GameState` singleton holds `final_score` and `wave_reached`; script reads from `GameState` if exports are default

## 5. Implementation Steps

1. Create `scenes/ui/game_over_screen.tscn` with the node hierarchy above
2. Create `scripts/ui/game_over_screen.gd` with the script above
3. Attach `game_over_screen.gd` to the Control root node
4. In `arena.tscn`, add two connections:
   - `player`/`player_died` → `game_over_screen` (set `victory=false`, `final_score=`, `wave_reached=`)
   - `wave_spawner`/`all_waves_complete` → `game_over_screen` (set `victory=true`, ...)
5. Confirm `project.godot` has `scenes/ui/` in the scene list (non-blocking, Godot auto-imports)
6. Run `godot4 --headless --path . --quit` to validate scene loads

## 6. AC Mapping

| AC | Verification |
|----|--------------|
| AC-1: `game_over.tscn` exists with Control root | `ls scenes/ui/game_over_screen.tscn` + grep `extends Control` in the file |
| AC-2: Shows Game Over or Victory text | grep `"GAME OVER"\|"VICTORY!"` in `game_over_screen.gd` |
| AC-3: Displays score and wave reached | grep `ScoreLabel\|WaveLabel` in script; verify label wired in `_ready()` |
| AC-4: Play Again and Main Menu buttons | grep `PlayAgainButton\|MainMenuButton` in script; verify `pressed.connect` calls |
| AC-5: Scene loads without errors | `godot4 --headless --path . --quit` EXIT:0 |

## 7. Validation Plan

1. `ls scenes/ui/game_over_screen.tscn` — file exists
2. `grep -c "extends Control" scenes/ui/game_over_screen.tscn` — ≥1 match
3. `grep "GAME OVER" scripts/ui/game_over_screen.gd` — result label present
4. `grep "VICTORY!" scripts/ui/game_over_screen.gd` — victory label present
5. `grep "ScoreLabel\|WaveLabel" scripts/ui/game_over_screen.gd` — score/wave labels wired
6. `grep "PlayAgainButton\|MainMenuButton" scripts/ui/game_over_screen.gd` — both buttons wired
7. `grep "change_scene_to_file.*arena" scripts/ui/game_over_screen.gd` — Play Again → arena
8. `grep "change_scene_to_file.*title" scripts/ui/game_over_screen.gd` — Main Menu → title
9. `godot4 --headless --path . --quit` — EXIT:0

## 8. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Score/wave not propagated from game state to game_over_screen | medium | medium | Use exported vars set by caller at scene change time; GameState singleton fallback |
| Victory signal `all_waves_complete` not wired in arena.tscn | low | medium | Review CORE-003 artifacts confirms signal exists; implementation step 4 adds connection |
| Button size too small for touch (under 48dp) | medium | low | Set button Custom Minimum Size height = 64 in scene, verified in validation step |
| game_over_screen.tscn not added to project.godot scene list | low | low | Godot auto-imports on load; `godot4 --headless --quit` validates |
| Scene hierarchy mismatch (wrong node paths in script) | medium | high | Script uses exact named children matching scene structure; validation step 3-8 verify |

## 9. Blockers

**Zero blockers.** All dependencies are satisfied:
- `UI-001` (title screen) is done and confirms `title_screen.tscn` path
- `CORE-003` (wave spawner) is done and confirms `all_waves_complete` signal exists
- `CORE-005` (collision/damage) is done and confirms `player_died` signal exists
- Bootstrap is ready (`bootstrap_status: ready` per START-HERE.md)

## 10. Precedents

- `UI-001` (title screen) — same scene structure pattern (Control → CenterContainer → VBoxContainer → Label/Button)
- `CORE-004` (HUD) — confirms CanvasLayer + Control hierarchy for UI in this project
