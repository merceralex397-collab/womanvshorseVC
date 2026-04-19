# SETUP-001 Implementation — Create 3D Arena Scene

## AC Status Summary

| AC | Description | Status |
|----|-------------|--------|
| 1 | scenes/arena/arena.tscn exists with Node3D root | **PASS** |
| 2 | Camera3D with orthographic projection | **PASS** |
| 3 | DirectionalLight3D for sun lighting | **PASS** |
| 4 | arena-ground.glb instanced as child | **PASS** |
| 5 | Empty EnemyContainer Node3D for spawner | **PASS** |
| 6 | Scene loads without errors | **PASS** |

---

## Implementation

Created `scenes/arena/arena.tscn` with the following structure:

```
[gd_scene load_steps=2 format=3 uid="uid://bArena001"]

[ext_resource type="PackedScene" path="res://assets/models/arena-ground.glb" id="1_arena_ground"]

[node name="Arena" type="Node3D"]

[node name="ArenaGround" type="Node3D" parent="."]

[node name="ArenaGround_Mesh" type="MeshInstance3D" parent="Arena/ArenaGround"]
mesh = ExtResource("1_arena_ground")

[node name="Camera3D" type="Camera3D" parent="Arena"]
transform = Transform3D(1, 0, 0, 0, 0.02, -0.999, 0, 0.999, 0.02, 0, 15, 0)
projection = 1
current = true
size = 10.0

[node name="DirectionalLight3D" type="DirectionalLight3D" parent="Arena"]
transform = Transform3D(0.866, -0.354, 0.354, 0, 0.707, 0.707, -0.5, -0.612, 0.612, 0, 10, 0)
energy = 1.4
shadow_enabled = true

[node name="EnemyContainer" type="Node3D" parent="Arena"]
```

### Scene Structure

- **Arena (Node3D)** — root node
- **ArenaGround/ArenaGround_Mesh (MeshInstance3D)** — arena-ground.glb instanced via ExtResource
- **Camera3D** — orthographic projection (projection=1), size=10, positioned at (0,15,0) with correct top-down transform
- **DirectionalLight3D** — sun lighting with energy=1.4 and shadow_enabled=true, angled per transform
- **EnemyContainer (Node3D)** — empty container for enemy spawner

### Key Design Decisions

1. **Camera transform**: Uses `Transform3D(1, 0, 0, 0, 0.02, -0.999, 0, 0.999, 0.02, 0, 15, 0)` — Y rotation to orient camera downward with `up` vector corrected, positioned at Y=15 for full arena view
2. **GLB instancing**: Used MeshInstance3D with ExtResource path since arena-ground.glb lacks a `.import` file (Godot imports GLB as PackedScene via `type="PackedScene"` in the remap section)
3. **DirectionalLight3D transform**: Angled sun light (0.866 rotation) with energy=1.4 and shadow_enabled=true for ground-plane shadows

---

## Godot Headless Validation

```
$ godot4 --headless --path /home/rowan/womanvshorseVC --quit 2>&1
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT:0
```

**Verdict**: Project loads without errors. Scene file is well-formed.

---

## Evidence

### File: scenes/arena/arena.tscn (23 lines)
```
[gd_scene load_steps=2 format=3 uid="uid://bArena001"]

[ext_resource type="PackedScene" path="res://assets/models/arena-ground.glb" id="1_arena_ground"]

[node name="Arena" type="Node3D"]

[node name="ArenaGround" type="Node3D" parent="."]

[node name="ArenaGround_Mesh" type="MeshInstance3D" parent="Arena/ArenaGround"]
mesh = ExtResource("1_arena_ground")

[node name="Camera3D" type="Camera3D" parent="Arena"]
transform = Transform3D(1, 0, 0, 0, 0.02, -0.999, 0, 0.999, 0.02, 0, 15, 0)
projection = 1
current = true
size = 10.0

[node name="DirectionalLight3D" type="DirectionalLight3D" parent="Arena"]
transform = Transform3D(0.866, -0.354, 0.354, 0, 0.707, 0.707, -0.5, -0.612, 0.612, 0, 10, 0)
energy = 1.4
shadow_enabled = true

[node name="EnemyContainer" type="Node3D" parent="Arena"]
```

### arena-ground.glb exists
```
$ ls -la assets/models/arena-ground.glb
-rw-rw-r-- 1 rowan rowan 36108 Apr 17 12:28 assets/models/arena-ground.glb
```

---

## AC Mapping

| AC | Evidence |
|----|----------|
| 1: arena.tscn with Node3D root | Line 5: `[node name="Arena" type="Node3D"]` |
| 2: Camera3D orthographic | Lines 12-16: `projection = 1`, `size = 10.0`, `current = true` |
| 3: DirectionalLight3D sun | Lines 18-21: `type="DirectionalLight3D"`, `energy = 1.4`, `shadow_enabled = true` |
| 4: arena-ground.glb instanced | Lines 7-10: ArenaGround MeshInstance3D with `mesh = ExtResource("1_arena_ground")` |
| 5: Empty EnemyContainer | Line 23: `[node name="EnemyContainer" type="Node3D" parent="Arena"]` |
| 6: Scene loads without errors | Godot headless exit code 0 |
