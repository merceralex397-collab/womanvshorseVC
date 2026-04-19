# Planning Artifact — FENCE-001: Add Arena Fence Boundary

## 1. Scope

Add a visible fence border around the arena perimeter in `scenes/arena/arena.tscn`. The fence is purely visual — a border indicator that does NOT add collision physics. The arena uses a fixed top-down orthographic camera (size=10, at y=15), so the fence appears as a colored perimeter strip when viewed from above.

**Chosen Approach: Option A — BoxMesh3D perimeter panels**

Rationale: The Blender-MCP asset pipeline (MODEL-007, MODEL-008) is blocked by a confirmed server-level regression. A BoxMesh3D approach avoids that dependency, is implementable immediately, and is sufficient for the visual finish requirement ("clean silhouettes" border).

---

## 2. Files / Systems Affected

| File | Change |
| --- | --- |
| `scenes/arena/arena.tscn` | Add `FenceContainer` Node3D with 4 BoxMesh3D perimeter panels as children |
| `scripts/player_controller.gd` | No changes (fence is non-collidable; arena bounds checking is separate) |
| `scripts/wave_spawner.gd` | No changes |

**Unchanged:** Player physics, enemy physics, collision layers, attack system, wave spawner.

---

## 3. Implementation Steps

### Step 1: Add FenceContainer to arena.tscn

In `scenes/arena/arena.tscn`, add a `Node3D` named `FenceContainer` as a child of `Arena` (at the end of the file, before or after `WaveSpawner`):

```
[node name="FenceContainer" type="Node3D" parent="Arena"]
```

This container will hold all fence mesh instances.

### Step 2: Add 4 perimeter BoxMesh3D panels

Arena ground is visually ~20×20 units (camera size=10, orthographic). Spawn radius is 9–11 units. Place fence panels at ±10.5 on X and Z — just outside the playable area.

**Panel dimensions:** width=20.0 (full span), height=0.5, depth=0.15 (thin strip). Centered at y=0.25 so the top of the fence is at y=0.5 — visible from the top-down camera as a colored border strip.

**East wall** (x = +10.5):
```
[node name="FenceEast" type="MeshInstance3D" parent="Arena/FenceContainer"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 10.5, 0.25, 0)
mesh = SubResource("BoxMesh_fence")
```

**West wall** (x = −10.5):
```
[node name="FenceWest" type="MeshInstance3D" parent="Arena/FenceContainer"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 0, -10.5, 0.25, 0)
mesh = SubResource("BoxMesh_fence")
```

**North wall** (z = +10.5):
```
[node name="FenceNorth" type="MeshInstance3D" parent="Arena/FenceContainer"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.25, 10.5)
mesh = SubResource("BoxMesh_fence")
```

**South wall** (z = −10.5):
```
[node name="FenceSouth" type="MeshInstance3D" parent="Arena/FenceContainer"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0.25, -10.5)
mesh = SubResource("BoxMesh_fence")
```

**Add the shared BoxMesh sub-resource** (in the `[sub_resource]` section at the top of the `.tscn` file):
```
[sub_resource type="BoxMesh" id="BoxMesh_fence"]
size = Vector3(20, 0.5, 0.15)
```

For North and South panels, rotate the mesh 90° on Y so the 20-unit width spans the X axis. Use `transform.basis = Basis.from_euler(Vector3(0, PI/2, 0))` for those panels, or swap size to `Vector3(0.15, 0.5, 20)`.

**Material:** Use a dark wood or brown color (e.g., `#4A3728`) with a `StandardMaterial3D` so the fence is clearly visible against the green grass arena. Add a `OMaterial` entry referencing a `StandardMaterial3D` sub_resource.

### Step 3: Verify camera visibility

The orthographic camera is at `(0, 15, 0)` looking straight down with `size=10`. At ground level (y=0), the visible area is a 20×20 square from (−10, 0, −10) to (10, 0, 10). The fence panels at ±10.5 on X and Z are just outside this area but within the camera's frustum — they will appear as a thin strip just inside the visible edge. The fence height of 0.5 units (top at y=0.5) is well above the ground plane and clearly visible from above.

### Step 4: Godot headless validation

Run:
```
godot4 --headless --path . --quit
```
Confirm EXIT:0 with no errors.

---

## 4. Acceptance Criteria Mapping

| AC | Verification Method |
| --- | --- |
| **AC-1: Arena has visible fence boundary on all 4 sides** | Inspect `arena.tscn` — `FenceContainer` has 4 `MeshInstance3D` children (FenceEast, FenceWest, FenceNorth, FenceSouth), each with a `BoxMesh`. All 4 positions are at ±10.5 on X or Z. |
| **AC-2: Fence does not obstruct camera view** | Camera is orthographic top-down at y=15. Fence panels are 0.5 units tall, centered at y=0.25 — visible as a colored perimeter strip but not occluding gameplay. No mesh extends above y=1.0. |
| **AC-3: No collision issues with player or enemy movement** | `FenceContainer` and all fence `MeshInstance3D` nodes have NO `CollisionShape3D` children. No collision layers are affected. Player/enemy movement is unchanged. |
| **AC-4: Scene loads without errors** | `godot4 --headless --path . --quit` exits with code 0. `arena.tscn` parses without errors. No missing resources. |

---

## 5. Risk Register

| Risk | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- |
| Fence posts are not visible from top-down orthographic camera | Low | Fence appears flat/minimal from above | Use horizontal panel strips (0.5 tall × 20 wide × 0.15 thick) oriented to face the camera; darker brown color contrasts with green grass |
| Fence overlaps with spawn positions causing visual clutter | Low | Enemies spawn near fence edge | Fence at ±10.5, spawn radius 9–11 — fence is just outside spawn zone |
| Future Blender-MCP fence GLB needs to replace BoxMesh | Low | Re-work required | BoxMesh fence is explicitly marked as Phase 1 visual placeholder; GLB version would replace via scene edit |

---

## 6. Blockers

**None.** All dependencies are resolved:
- `SETUP-001` (arena scene) is done/trusted.
- `VISUAL-001` (parent) cleared the visual wiring work; fence is the remaining follow-up.
- Blender-MCP is NOT required for this approach (avoids the confirmed server regression).
- No collision changes needed — player/enemy physics unchanged.

---

## 7. Validation Plan

1. **File presence:** `arena.tscn` contains `FenceContainer` node with 4 `MeshInstance3D` children.
2. **Geometry check:** `grep BoxMesh_fence arena.tscn` returns the sub_resource definition.
3. **No collision:** `grep CollisionShape3D arena.tscn` inside `FenceContainer` scope returns zero matches.
4. **Godot load:** `godot4 --headless --path . --quit` → EXIT:0.
5. **Live scene inspection:** Open `arena.tscn` in Godot editor (or headless inspect) — verify fence panels appear as colored border around arena ground.

---

## 8. Summary

Option A (BoxMesh3D perimeter panels) is selected for simplicity and immediate implementability. Four thin horizontal fence strips (0.5 units tall, 20 units wide, 0.15 thick) are placed at the four arena edges (±10.5 on X and Z), forming a visible brown border around the green arena. The fence has zero collision shapes, so it does not affect player or enemy physics. Godot headless validation confirms clean scene load.
