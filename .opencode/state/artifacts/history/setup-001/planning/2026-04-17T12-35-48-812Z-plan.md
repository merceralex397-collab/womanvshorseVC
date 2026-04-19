# Plan: SETUP-001 — Create 3D Arena Scene

## 1. Scope

Create the main 3D arena scene (`scenes/arena/arena.tscn`) as the foundational game scene for the Woman vs Horse VC Godot 4.6 Android project. The scene establishes the fixed top-down orthographic view, sun lighting, the imported arena-ground GLB model, and the enemy spawn container node.

## 2. Files & Systems Affected

| File/Directory | Effect |
|---|---|
| `scenes/arena/arena.tscn` | New arena scene file with Node3D root and all children |
| `assets/models/arena-ground.glb` | Read by MeshInstance3D (already imported by MODEL-006) |

No modifications to `project.godot` are required for this scene to load.

## 3. Implementation Steps

### Step 1 — Create scene directory and file

Create `scenes/arena/` directory. Write `scenes/arena/arena.tscn` with the following GDScript-based approach (Godot 4 scene format):

```
[gd_scene load_steps=2 format=3]

[ext_resource type="PackedScene" uid="uid://bx_arena_ground" path="res://assets/models/arena-ground.glb" id="1_arena_ground"]

[node name="Arena" type="Node3D"]

[node name="EnemyContainer" type="Node3D" parent="."]

[node name="Camera3D" type="Camera3D" parent="."]
projection = 1  # ORTHOGONAL
size = 10.0
near = 0.1
far = 100.0
current = true

[node name="SunLight" type="DirectionalLight3D" parent="."]
transform = Transform3D(0.866025, -0.353553, 0.353553, 0, 0.707107, 0.707107, -0.5, -0.612372, 0.612372, 0, 8, 0)
light_energy = 1.4

[node name="ArenaGround" type="Node3D" parent="."]
```

Wait — Godot 4 `.tscn` format does not directly embed GLB data. The correct approach is:

### Step 1 (Revised) — Create arena scene using GDScript loader

Write `scenes/arena/arena.tscn` as a pure scene definition referencing the GLB via an `[ext_resource]` PackedScene:

```
[gd_scene load_steps=2 format=3]

[ext_resource type="PackedScene" path="res://assets/models/arena-ground.glb" id="1_ground"]

[node name="Arena" type="Node3D"]

[node name="EnemyContainer" type="Node3D" parent="."]

[node name="Camera3D" type="Camera3D" parent="."]
projection = 1
size = 10.0
near = 0.1
far = 100.0
current = true

[node name="SunLight" type="DirectionalLight3D" parent="."]
transform = Transform3D(0.866025, -0.353553, 0.353553, 0, 0.707107, 0.707107, -0.5, -0.612372, 0.612372, 0, 8, 0)
light_energy = 1.4

[node name="ArenaGround" parent="." instance=ExtResource("1_ground")]
```

Note: When Godot imports a `.glb` file, it creates a `.glb.import` file and a corresponding `uid://*` resource. The `instance=ExtResource("1_ground")` on a `Node3D` will instantiate the GLB's root node as a child of `Arena`.

If Godot does not produce a PackedScene for a bare GLB (only a Mesh resource), use this fallback — create a `MeshInstance3D` that loads the mesh directly:

**Fallback scene (if GLB imports as mesh, not scene):**

```
[gd_scene load_steps=2 format=3]

[ext_resource type="Mesh" uid="uid://bx_arena_ground_mesh" path="res://assets/models/arena-ground.glb" id="1_ground_mesh"]

[node name="Arena" type="Node3D"]

[node name="EnemyContainer" type="Node3D" parent="."]

[node name="Camera3D" type="Camera3D" parent="."]
projection = 1
size = 10.0
near = 0.1
far = 100.0
current = true

[node name="SunLight" type="DirectionalLight3D" parent="."]
transform = Transform3D(0.866025, -0.353553, 0.353553, 0, 0.707107, 0.707107, -0.5, -0.612372, 0.612372, 0, 8, 0)
light_energy = 1.4

[node name="ArenaGround" type="MeshInstance3D" parent="."]
mesh = ExtResource("1_ground_mesh")
```

### Step 2 — Determine which import form the GLB produces

Run the Godot import to see whether `assets/models/arena-ground.glb` resolves as a `PackedScene` (instanced via `instance=`) or as a `Mesh` (assigned to a `MeshInstance3D`). The scene file will be written with whichever form Godot actually produces. If both forms exist, prefer the `PackedScene` / `Node3D` instance form as it correctly preserves multi-material meshes.

### Step 3 — Validate scene loads without errors

Run:

```
godot --headless --path . --quit
```

Confirm no errors related to `scenes/arena/arena.tscn`.

## 4. Node Structure

```
Arena (Node3D)
├── EnemyContainer (Node3D)          # Empty container for wave spawner
├── Camera3D                         # Orthographic, top-down, fixed
│   └── projection = 1 (ORTHOGONAL)
│   └── size = 10.0
│   └── current = true
├── SunLight (DirectionalLight3D)    # Sun illumination
│   └── light_energy = 1.4
│   └── transform: angled ~45° for shadows
└── ArenaGround (Node3D or MeshInstance3D)
    └── [instanced arena-ground.glb]
```

## 5. Camera Configuration

| Property | Value | Rationale |
|---|---|---|
| `projection` | `1` (ORTHOGONAL) | Fixed top-down orthographic view per spec |
| `size` | `10.0` | Covers the ~12×12 arena ground with margin |
| `near` | `0.1` | Standard near plane |
| `far` | `100.0` | Large far plane for safety |
| `current` | `true` | Makes this the active camera |

Camera position is implicit from the look-direction (default -Z facing). No explicit transform required if camera node position is `(0, 10, 0)` with look_at pointing at `(0, 0, 0)`. If transform is needed:

```
[node name="Camera3D" type="Camera3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 10, 0)
projection = 1
size = 10.0
current = true
```

## 6. Lighting Configuration

| Property | Value | Rationale |
|---|---|---|
| `light_energy` | `1.4` | Matches existing main.tscn; enough brightness for stylized look |
| `transform` | ~45° angle | Directional sun casting visible shadows on arena |

This matches the existing `DirectionalLight3D` in `scenes/main.tscn` which has proven valid.

## 7. Acceptance Criteria Mapping

| AC | Verification Method |
|---|---|
| `scenes/arena/arena.tscn exists with Node3D root` | File exists; root node is `Node3D` named `Arena` |
| `Camera3D with orthographic projection` | `projection = 1` in `.tscn` |
| `DirectionalLight3D for sun lighting` | Node of type `DirectionalLight3D` present |
| `arena-ground.glb instanced as child` | GLB resource loaded; child node present under `Arena` |
| `Empty EnemyContainer Node3D for spawner` | `Node3D` named `EnemyContainer` with no children |
| `Scene loads without errors` | `godot --headless --path . --quit` exits cleanly |

## 8. Risks & Assumptions

| Risk | Likelihood | Mitigation |
|---|---|---|
| GLB imports as Mesh, not PackedScene, changing the instancing approach | Low | Fallback MeshInstance3D approach is documented |
| Camera FOV/size wrong for arena coverage | Low | Size=10.0 with ~12-unit arena gives comfortable margin |
| Scene does not load due to missing resource import | Medium | Verify GLB import path resolves before scene load |
| EnemyContainer positioning wrong for spawner | Low | Empty Node3D at root level; spawner code will set world position |

## 9. Blockers & Open Decisions

- **No blockers** — MODEL-006 (arena-ground.glb) is complete and trusted. Bootstrap is ready.
- **Open decision**: Whether Godot imports arena-ground.glb as PackedScene or Mesh — resolved at implementation time by inspecting the actual import output.

## 10. Dependency Status

- ✅ MODEL-006 (arena-ground.glb) — done, trusted
- Bootstrap — ready
