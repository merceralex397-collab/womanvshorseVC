# Plan — UI-001: Title screen

## 1. Scope

Deliver a title screen scene (`scenes/ui/title_screen.tscn`) with a game title label, a "Start Game" button, and a script that transitions to the arena scene (`res://scenes/arena/arena.tscn`). Touch-friendly layout with ≥48dp-equivalent button sizing. Godot headless validation confirms the scene loads without errors.

---

## 2. Files / Systems Affected

| File | Action |
| --- | --- |
| `scenes/ui/title_screen.tscn` | **Created** — Control root scene |
| `scripts/ui/title_screen.gd` | **Created** — button handler + scene transition |
| `project.godot` | **Modified** — `run/main_scene` updated to title screen |

No existing gameplay scripts are modified. No dependency on pending tickets.

---

## 3. Scene Structure

```
Control (root, full-screen anchors)
└── CenterContainer
    └── VBoxContainer
        ├── Label (game title, large font, centered)
        └── Button (Start Game, touch-friendly, accent color)
```

**Node details:**
- `Control`: `anchors_preset = 15` (FULL_RECT), `mouse_filter = IGNORE`
- `CenterContainer`: default CenterContainer; centers its child
- `VBoxContainer`: default VBoxContainer with `alignment = CENTER`
- `Label`: `theme_override_font_sizes/font_size = 48`, `horizontal_alignment = 1` (center)
- `Button`: `custom_minimum_size = Vector2(200, 64)` (~48dp+ on typical Android DPI), `horizontal_alignment = 1`

---

## 4. Script Design — `title_screen.gd`

```gdscript
extends Control

@onready var start_button: Button = $StartButton

func _ready():
    start_button.pressed.connect(_on_start_pressed)

func _on_start_pressed():
    get_tree().change_scene_to_file("res://scenes/arena/arena.tscn")
```

**Behavior:**
- `_ready()` wires the button pressed signal
- `_on_start_pressed()` calls `get_tree().change_scene_to_file()` to load arena
- No additional input actions required; `project.godot` input actions already defined (CORE-001)

---

## 5. Implementation Steps

1. **Create `scenes/ui/title_screen.tscn`**
   - Add `[gd_scene]` header with format=3 uid
   - Add `Control` node as root with `anchors_preset = 15`, `mouse_filter = IGNORE`
   - Add `CenterContainer` child
   - Add `VBoxContainer` child of CenterContainer, `alignment = CENTER`
   - Add `Label` child of VBoxContainer with `text = "Woman vs Horse VC"`, `theme_override_font_sizes/font_size = 48`, `horizontal_alignment = 1`
   - Add `Button` child of VBoxContainer with `text = "Start Game"`, `custom_minimum_size = Vector2(200, 64)`, `horizontal_alignment = 1`

2. **Create `scripts/ui/title_screen.gd`**
   - `extends Control`
   - `@onready var start_button: Button = $StartButton`
   - `func _ready()` wiring `start_button.pressed.connect(_on_start_pressed)`
   - `func _on_start_pressed()` calling `get_tree().change_scene_to_file("res://scenes/arena/arena.tscn")`

3. **Wire the script into the scene**
   - Add `[ext_resource type="Script" path="res://scripts/ui/title_screen.gd" id="1_title"]` to scene
   - Attach `script = ExtResource("1_title")` to the root Control node

4. **Update `project.godot`**
   - Change `run/main_scene` from `"res://scenes/main.tscn"` to `"res://scenes/ui/title_screen.tscn"`
   - If `main.tscn` does not exist, this line may need to be created or the existing path corrected

5. **Godot headless validation**
   - Run: `godot4 --headless --path . --quit`
   - Expected: exit code 0

---

## 6. Acceptance Criteria Mapping

| AC | Description | Evidence |
| --- | --- | --- |
| AC-1 | `title_screen.tscn` exists with Control root | File exists at `scenes/ui/title_screen.tscn`; root node is `Control` |
| AC-2 | Displays game title | Label node with `text = "Woman vs Horse VC"` present in scene |
| AC-3 | Start Game button transitions to arena | Button node present; `title_screen.gd` calls `change_scene_to_file("res://scenes/arena/arena.tscn")` |
| AC-4 | Touch-friendly layout | Button `custom_minimum_size = Vector2(200, 64)` ≥ ~48dp on Android |
| AC-5 | Scene loads without errors | `godot4 --headless --path . --quit` exits 0 |

---

## 7. Validation Plan

1. **AC-1** — `ls scenes/ui/title_screen.tscn && head -5 scenes/ui/title_screen.tscn | grep "gd_scene"` — confirms file exists and is a Godot scene
2. **AC-2** — `grep -n "Woman vs Horse" scenes/ui/title_screen.tscn` — confirms title label text
3. **AC-3** — `grep -n "change_scene_to_file" scripts/ui/title_screen.gd && grep -n "arena.tscn" scripts/ui/title_screen.gd` — confirms scene transition to arena path
4. **AC-4** — `grep -n "custom_minimum_size" scenes/ui/title_screen.tscn` — confirms ≥48dp equivalent
5. **AC-5** — `godot4 --headless --path . --quit` — must exit 0

---

## 8. Risk Register

| Risk | Severity | Mitigation |
| --- | --- | --- |
| `project.godot` `run/main_scene` path points to non-existent `main.tscn` | Low | Verify path before Godot validation; update to title_screen if needed |
| Arena scene path changed | Low | Confirm arena.tscn at `res://scenes/arena/arena.tscn` (SETUP-001 artifact confirms) |
| Button text / style not touch-friendly | Low | Set `custom_minimum_size = Vector2(200, 64)` above 48dp minimum |
| Title label font too small | Low | Use `theme_override_font_sizes/font_size = 48` for readable title |
| Missing `scenes/ui/` directory | Medium | Pre-check; create directory if needed |

---

## 9. Blockers

- **Arena scene dependency** — `res://scenes/arena/arena.tscn` exists (SETUP-001 done, verified in artifact registry)
- **Bootstrap** — Not required for UI-only scene creation; no external runtime dependencies
- **Input actions** — Already defined in `project.godot` (CORE-001)
- **Main scene path** — `project.godot` currently references `res://scenes/main.tscn` which does not exist; this will be updated to the title screen path — no blocker, this is part of the ticket scope

**Conclusion:** All dependencies are ready. No blockers.
