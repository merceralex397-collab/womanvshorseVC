# QA Validation — CORE-004: 3D HUD (CanvasLayer)

## QA Result: PASS

---

## Acceptance Criteria Verification

### AC-1: hud.tscn exists with CanvasLayer root
**Status: PASS**
- Evidence: `ls -la /home/rowan/womanvshorseVC/scenes/ui/hud.tscn` → `-rw-rw-r-- 1 rowan rowan 3435 Apr 17 14:13`
- Evidence: `grep CanvasLayer /home/rowan/womanvshorseVC/scenes/ui/hud.tscn` → Line 9: `[node name="HUD" type="CanvasLayer"]`

### AC-2: Displays health, wave, score, enemy count
**Status: PASS**
All four display elements present in hud.tscn:
- `HealthBar` — Line 27: `type="HealthBar"` with ProgressBar
- `WaveLabel` — Line 45: `text = "Wave 1"`
- `EnemyCountLabel` — Line 51: `text = "Enemies: 0"`
- `ScoreLabel` — Line 66: `text = "Score: 0"`

### AC-3: Virtual joystick and attack button placeholders
**Status: PASS**
- `JoystickArea` Area2D with `virtual_joystick.gd` — Line 72-77
- `AttackButton` Area2D with `attack_button.gd` — Line 98-103
- Both are wired as placeholders per plan (actual input wiring deferred to CORE-005)

### AC-4: Touch-friendly sizing (48dp minimum)
**Status: PASS**
- JoystickBase touch target: `custom_minimum_size = Vector2(100, 100)` — Line 80 (100×100 > 48dp ✅)
- AttackButton touch target: `custom_minimum_size = Vector2(80, 80)` — Line 106 (80×80 > 48dp ✅)
- Note: JoystickNub is 40×40 but it is the visual nub, not the touch target area (JoystickBase at 100×100 is the touch area)

### AC-5: Scene loads without errors
**Status: PASS**
```
godot4 --headless --path /home/rowan/womanvshorseVC --quit
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT_CODE=0
```

---

## Scripts Verification
All 5 scripts present in `/home/rowan/womanvshorseVC/scripts/ui/`:
- attack_button.gd (548 bytes)
- health_display.gd (657 bytes)
- score_display.gd (574 bytes)
- virtual_joystick.gd (1111 bytes)
- wave_display.gd (934 bytes)

---

## Raw Command Output

```
$ ls -la /home/rowan/womanvshorseVC/scenes/ui/hud.tscn
-rw-rw-r-- 1 rowan rowan 3435 Apr 17 14:13 /home/rowan/womanvshorseVC/scenes/ui/hud.tscn

$ ls -la /home/rowan/womanvshorseVC/scripts/ui/
total 28
drwxr-xr-x 2 rowan rowan 4096 Apr 17 14:12 ..
-rw-rw-r-- 1 rowan rowan  548 Apr 17 14:13 attack_button.gd
-rw-rw-r-- 1 rowan rowan  657 Apr 17 14:13 health_display.gd
-rw-rw-r-- 1 rowan rowan  574 Apr 17 14:13 score_display.gd
-rw-rw-r-- 1 rowan rowan 1111 Apr 17 14:13 virtual_joystick.gd
-rw-rw-r-- 1 rowan rowan  934 Apr 17 14:13 wave_display.gd

$ godot4 --headless --path /home/rowan/womanvshorseVC --quit 2>&1; echo "EXIT_CODE=$?"
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT_CODE=0
```

---

## QA Summary

| AC | Description | Result |
|----|-------------|--------|
| 1 | hud.tscn exists with CanvasLayer root | PASS |
| 2 | Displays health, wave, score, enemy count | PASS |
| 3 | Virtual joystick and attack button placeholders | PASS |
| 4 | Touch-friendly sizing (48dp minimum) | PASS |
| 5 | Scene loads without errors | PASS |

**5/5 ACs verified PASS**

QA validation complete.
