# Plan: CORE-004 — 3D HUD (CanvasLayer)

## 1. Scope

Create `hud.tscn`, a CanvasLayer-based in-game HUD overlay for the Woman vs Horse VC 3D top-down arena game. The HUD displays player health, wave number, score, and enemy count; provides a virtual joystick for movement; and provides an attack button placeholder. All touch-interactive elements meet the 48dp minimum sizing requirement.

## 2. Files / Systems Affected

| File | Purpose |
|---|---|
| `scenes/ui/hud.tscn` | CanvasLayer root scene with all HUD children |
| `scripts/ui/health_display.gd` | Updates health bar and text |
| `scripts/ui/wave_display.gd` | Updates wave counter and enemy count |
| `scripts/ui/score_display.gd` | Updates score label |
| `scripts/ui/virtual_joystick.gd` | Emits movement input direction (placeholder) |
| `scripts/ui/attack_button.gd` | Emits attack pressed signal (placeholder) |
| `project.godot` | Input actions: `move_jog`, `attack` (already present) |

## 3. Scene Structure

```
CanvasLayer (hud)
└── HUDRoot (Node, keeps children organized)
    ├── HealthContainer (HBoxContainer, top-left, MarginContainer)
    │   ├── HealthLabel (Label, "HP")
    │   └── HealthBar (TextureProgress)
    ├── WaveContainer (VBoxContainer, top-center)
    │   ├── WaveLabel (Label, "WAVE X")
    │   └── EnemyCountLabel (Label, "Enemies: N")
    ├── ScoreContainer (HBoxContainer, top-right)
    │   └── ScoreLabel (Label, "Score: 0")
    ├── JoystickArea (Area2D, bottom-left quadrant)
    │   ├── JoystickBase (Panel, 100×100px, dark semi-transparent circle)
    │   └── JoystickNub (Panel, 40×40px, lighter circle, center origin)
    └── AttackButton (Panel, bottom-right quadrant, 80×80px)
        └── AttackLabel (Label, "ATK")
```

**Anchor/Offset notes:**
- HealthContainer: `anchors preset = top_left`, `offset_left = 16`, `offset_top = 16`
- WaveContainer: `anchors preset = top_center`, `offset_top = 16`
- ScoreContainer: `anchors preset = top_right`, `offset_right = -16`, `offset_top = 16`
- JoystickArea: `anchors preset = bottom_left`, `offset_left = 40`, `offset_bottom = -40` — 100×100 touch zone
- AttackButton: `anchors preset = bottom_right`, `offset_right = -40`, `offset_bottom = -40` — 80×80

## 4. Script Design

### health_display.gd
- `export var health_path: NodePath` pointing to player Health Node
- On `_ready()`: connect to health signal or poll initial value
- Updates `HealthBar.value` and optional `HealthLabel` text
- Pattern: listens to `HealthComponent.health_changed` or similar player signal

### wave_display.gd
- `export var wave_spawner_path: NodePath` pointing to WaveSpawner
- On `_ready()`: connect to `wave_started` and `wave_cleared` signals
- Updates `WaveLabel.text` = "WAVE %d" and `EnemyCountLabel.text` = "Enemies: %d`

### score_display.gd
- Listens to `PlayerController.score_changed` or global `score` signal
- Updates `ScoreLabel.text` = "Score: %d"
- Could also connect to enemy death events that grant score

### virtual_joystick.gd
- `extends Area2D` with `collision_layer = 0`, `collision_mask = 0` (input-only, no physics)
- Tracks touch via `_input_event(viewport, event, shape_idx)`
- Emits `signal moved(direction: Vector2)` while dragging
- Clamps nub to joystick base radius
- Releases snap nub to center on touch end
- **Placeholder behaviour:** drag updates nub position; no actual player movement wiring (CORE-005 wires that)

### attack_button.gd
- `extends Area2D` with `collision_layer = 0`, `collision_mask = 0`
- On `_input_event`: emits `signal pressed` on touch down (not release)
- **Placeholder behaviour:** emits signal only; CORE-005 wires to attack system

## 5. Acceptance Criteria Mapping

| # | Criterion | Evidence |
|---|---|---|
| AC-1 | hud.tscn exists with CanvasLayer root | `scenes/ui/hud.tscn` on disk; `CanvasLayer` is root node; Godot headless loads scene without errors |
| AC-2 | Displays health, wave, score, enemy count | Labels and/or TextureProgress present with correct initial text; scripts expose update methods |
| AC-3 | Virtual joystick and attack button placeholders | JoystickArea Area2D with base+nub Panel children; AttackButton Panel with ATK Label |
| AC-4 | Touch-friendly sizing (48dp minimum) | JoystickBase = 100×100px (>48dp); AttackButton = 80×80px (>48dp); JoystickNub = 40×40px |
| AC-5 | Scene loads without errors | `godot --headless --path . --quit` exit code 0 after scene is created |

## 6. Implementation Steps

1. Create `scenes/ui/` directory and `scripts/ui/` directory if they do not exist.
2. Create `scenes/ui/hud.tscn` with the node tree above using Godot editor-style `.tscn` text format:
   - CanvasLayer root
   - HUDRoot Node
   - HealthContainer (MarginContainer + HBoxContainer)
     - HealthLabel (Label, "HP")
     - HealthBar (TextureProgress, min=0 max=100 value=100)
   - WaveContainer (VBoxContainer)
     - WaveLabel (Label, "WAVE 1")
     - EnemyCountLabel (Label, "Enemies: 0")
   - ScoreContainer (HBoxContainer)
     - ScoreLabel (Label, "Score: 0")
   - JoystickArea (Area2D with CircleShape2D)
     - JoystickBase (Panel, dark circle via StyleBox)
     - JoystickNub (Panel, lighter circle via StyleBox)
   - AttackButton (Area2D with CircleShape2D)
     - AttackLabel (Label, "ATK")
3. Create `scripts/ui/health_display.gd` with exported `health_path` and signal wiring.
4. Create `scripts/ui/wave_display.gd` with exported `wave_spawner_path` and signal wiring.
5. Create `scripts/ui/score_display.gd` with signal wiring.
6. Create `scripts/ui/virtual_joystick.gd` with touch tracking and `moved` signal.
7. Create `scripts/ui/attack_button.gd` with touch-press and `pressed` signal.
8. Attach `health_display.gd` to HealthContainer; `wave_display.gd` to WaveContainer; `score_display.gd` to ScoreContainer; `virtual_joystick.gd` to JoystickArea; `attack_button.gd` to AttackButton.
9. Set initial placeholder values (wave=1, enemies=0, score=0, health=100).
10. Validate: run `godot --headless --path . --quit` — must exit 0.

## 7. Validation Plan

1. **File existence** — `ls scenes/ui/hud.tscn` confirms AC-1.
2. **Scene structure** — `grep` for `CanvasLayer` root and child node names confirms AC-1/AC-2/AC-3.
3. **Sizing** — check Panel custom_minimum_size values in `.tscn` confirm AC-4 (JoystickBase 100×100, AttackButton 80×80).
4. **Godot load** — `godot --headless --path . --quit` exit 0 confirms AC-5.
5. **Script presence** — `ls scripts/ui/*.gd` confirms all 5 scripts created.

## 8. Risks & Assumptions

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Player health / wave-spawner node paths change and break exported references | Low | Medium | Export node paths; use `find_node()` fallback with `push_warning()` if not found |
| Touch events conflict with Godot's built-in input handling | Low | Medium | Use `Area2D` with `_input_event` rather than `_input`; set `collision_layer=0` |
| `TextureProgress` not available in minimal project; use `ProgressBar` instead | Low | Low | Add fallback StyleBoxProgress if `TextureProgress` fails to load; both are valid |
| CanvasLayer z-index ordering needs tuning after 3D scene is wired | Low | Low | CanvasLayer renders above 3D by default; document `layer` property if adjustment needed |
| Placeholder joystick does not emit movement to player controller | Low | Low | Core-005 wires this; placeholder only needs to emit `moved` signal correctly |

## 9. Blockers

None. SETUP-001 (arena scene) is done and verified. No Blender-MCP or Android toolchain dependency.
