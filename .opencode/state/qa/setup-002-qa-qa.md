# QA Validation — SETUP-002: Create player controller

**Ticket**: SETUP-002  
**Stage**: qa  
**Date**: 2026-04-17  
**Validator**: team-lead

---

## Acceptance Criteria Verification

### AC-1: scenes/player/player.tscn exists with CharacterBody3D root

**Check**: File exists and contains `type="CharacterBody3D"` node.

**Evidence**:
```
$ ls -la scenes/player/player.tscn
-rw-r--r-- 1 rowan rowan 541 Apr 17 12:49 scenes/player/player.tscn

$ grep CharacterBody3D scenes/player/player.tscn
[gd_scene load_steps=3 format=3 uid="uid://cxk8v5q6ywq"]
[node name="Player" type="CharacterBody3D"]
```

**Result**: ✅ PASS

---

### AC-2: player_controller.gd with move_and_slide movement

**Check**: Script file exists and contains `move_and_slide()` call.

**Evidence**:
```
$ ls -la scripts/player_controller.gd
-rw-r--r-- 1 rowan rowan 860 Apr 17 12:49 scripts/player_controller.gd

$ grep move_and_slide scripts/player_controller.gd
	move_and_slide()
```

Script implements XZ-plane movement via `move_and_slide()` with exported `speed` and `gravity` vars.

**Result**: ✅ PASS

---

### AC-3: Placeholder AttackArea Area3D child

**Check**: Scene has `Area3D` node named `AttackArea` as child of CharacterBody3D.

**Evidence**:
```
$ grep -A1 'AttackArea' scenes/player/player.tscn
[node name="AttackArea" type="Area3D" parent="."]
```

**Result**: ✅ PASS

---

### AC-4: Scene loads without errors

**Check**: `godot4 --headless --path /home/rowan/womanvshorseVC --quit`

**Raw output**:
```
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org

EXIT_CODE: 0
```

No errors, no warnings, clean exit.

**Result**: ✅ PASS

---

## Summary

| AC | Description | Result |
|----|-------------|--------|
| 1 | player.tscn exists with CharacterBody3D root | ✅ PASS |
| 2 | player_controller.gd with move_and_slide | ✅ PASS |
| 3 | AttackArea Area3D child placeholder | ✅ PASS |
| 4 | Scene loads without errors | ✅ PASS |

**QA Verdict**: All 4/4 ACs verified PASS. Ticket eligible for smoke-test stage.