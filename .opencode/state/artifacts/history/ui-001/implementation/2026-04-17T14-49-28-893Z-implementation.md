# Implementation — UI-001: Title screen

## Summary
Created `scenes/ui/title_screen.tscn` with Control root → CenterContainer → VBoxContainer → Label + Button hierarchy, `scripts/ui/title_screen.gd` with button signal handler and scene transition, and updated `project.godot` to set `run/main_scene` to the title screen.

## Files Created

### `scenes/ui/title_screen.tscn`
- **Root:** Control node with `anchors_preset = 15` (FULL_RECT), `mouse_filter = IGNORE`
- **Child hierarchy:** CenterContainer → VBoxContainer (alignment=CENTER) → Label + Button
- **Label:** `text = "Woman vs Horse VC"`, `theme_override_font_sizes/font_size = 48`, `horizontal_alignment = 1` (center)
- **Button:** `text = "Start Game"`, `custom_minimum_size = Vector2(200, 64)`, `horizontal_alignment = 1`
- **Script:** ExtResource wired to `res://scripts/ui/title_screen.gd`

### `scripts/ui/title_screen.gd`
```gdscript
extends Control

@onready var start_button: Button = $CenterContainer/VBoxContainer/StartButton

func _ready():
    start_button.pressed.connect(_on_start_pressed)

func _on_start_pressed():
    get_tree().change_scene_to_file("res://scenes/arena/arena.tscn")
```

### `project.godot` (modified)
- Changed `run/main_scene` from `"res://scenes/main.tscn"` to `"res://scenes/ui/title_screen.tscn"`

## Acceptance Criteria Evidence

| AC | Status | Evidence |
|----|--------|----------|
| AC-1: title_screen.tscn exists with Control root | **PASS** | File exists at `scenes/ui/title_screen.tscn`; `[gd_scene]` header confirmed; root node is `Control` |
| AC-2: Displays game title | **PASS** | Label with `text = "Woman vs Horse VC"` present in scene hierarchy |
| AC-3: Start Game button transitions to arena | **PASS** | Button present; `change_scene_to_file("res://scenes/arena/arena.tscn")` in script |
| AC-4: Touch-friendly layout | **PASS** | Button `custom_minimum_size = Vector2(200, 64)` ≥ 48dp on Android |
| AC-5: Scene loads without errors | **PASS** | `godot4 --headless --path . --quit` EXIT:0 |

## Godot Headless Validation
```
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT:0
```
Clean exit — no script errors, no scene loading errors.

## Implementation Steps Completed
1. ✅ Created `scenes/ui/title_screen.tscn` with full node hierarchy
2. ✅ Created `scripts/ui/title_screen.gd` with button handler and scene transition
3. ✅ Wired script into scene via `[ext_resource]`
4. ✅ Updated `project.godot` `run/main_scene` to title_screen
5. ✅ Godot headless validation EXIT:0
