# Plan: MODEL-006 — Generate arena-ground via Blender-MCP

## 1. Scope

Generate the `arena-ground` environment model via the blender-agent MCP bridge, export as GLB to `assets/models/arena-ground.glb`, certify with quality_validate, and record provenance.

## 2. Files / Systems Affected

| Surface | Path |
|---|---|
| Blender staging | `/tmp/model-006/staging.blend` |
| Output GLB | `assets/models/arena-ground.glb` |
| Godot project | `/home/rowan/womanvshorseVC/project.godot` |
| Provenance log | `assets/PROVENANCE.md` |

## 3. Implementation Steps

### Step 1 — Bootstrap Blender environment
```python
blender_agent_environment_probe(project_root="/home/rowan/womanvshorseVC")
```
Confirm blender binary at `/home/pc/blender-4.5.0/blender` is reachable and MCP bridge is responsive before proceeding.

### Step 2 — Initialize staging file
```python
blender_agent_project_initialize(
  project_root="/home/rowan/womanvshorseVC",
  output_blend="/tmp/model-006/staging.blend",
  template="empty",
  units="METRIC",
  unit_scale=1.0,
  factory_startup=null
)
```

### Step 3 — Build all geometry in one scene_batch_edit
Compose all arena geometry (ground plane, fence posts, rails) in a single batch call to avoid chaining overhead:

```python
blender_agent_scene_batch_edit(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    # Ground plane: 20m × 20m quad, rotated flat (XY plane)
    {"action": "create_primitive", "primitive": "plane", "object": "GroundPlane", "location": [0, 0, 0], "rotation": [0, 0, 0], "scale": [20, 20, 1]},
    # Fence posts: 16 cubes at 5m intervals around perimeter + corners
    # 4 corners + 3 per side (at 5m, 10m, 15m from corner) = 16 posts
    {"action": "create_primitive", "primitive": "cube", "object": "Post_C00", "location": [-10, -10, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_C01", "location": [-10,  10, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_C10", "location": [ 10, -10, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_C11", "location": [ 10,  10, 0.5], "scale": [0.15, 0.15, 1.0]},
    # Posts along X=-10 edge (at Y=-5, 0, 5)
    {"action": "create_primitive", "primitive": "cube", "object": "Post_m10_E", "location": [-10, -5, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_m10_M", "location": [-10,  0, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_m10_W", "location": [-10,  5, 0.5], "scale": [0.15, 0.15, 1.0]},
    # Posts along X=+10 edge (at Y=-5, 0, 5)
    {"action": "create_primitive", "primitive": "cube", "object": "Post_p10_E", "location": [ 10, -5, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_p10_M", "location": [ 10,  0, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_p10_W", "location": [ 10,  5, 0.5], "scale": [0.15, 0.15, 1.0]},
    # Posts along Y=-10 edge (at X=-5, 0, 5)
    {"action": "create_primitive", "primitive": "cube", "object": "Post_m11_S", "location": [-5, -10, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_m11_M", "location": [ 0, -10, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_m11_N", "location": [ 5, -10, 0.5], "scale": [0.15, 0.15, 1.0]},
    # Posts along Y=+10 edge (at X=-5, 0, 5)
    {"action": "create_primitive", "primitive": "cube", "object": "Post_p11_S", "location": [-5,  10, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_p11_M", "location": [ 0,  10, 0.5], "scale": [0.15, 0.15, 1.0]},
    {"action": "create_primitive", "primitive": "cube", "object": "Post_p11_N", "location": [ 5,  10, 0.5], "scale": [0.15, 0.15, 1.0]},
    # Rails: horizontal connectors along each side at 0.3m and 0.7m height
    # X=-10 edge rails (along Y axis)
    {"action": "create_primitive", "primitive": "cube", "object": "Rail_m10_H1", "location": [-10, 0, 0.3], "scale": [0.05, 20, 0.05]},
    {"action": "create_primitive", "primitive": "cube", "object": "Rail_m10_H2", "location": [-10, 0, 0.7], "scale": [0.05, 20, 0.05]},
    # X=+10 edge rails
    {"action": "create_primitive", "primitive": "cube", "object": "Rail_p10_H1", "location": [ 10, 0, 0.3], "scale": [0.05, 20, 0.05]},
    {"action": "create_primitive", "primitive": "cube", "object": "Rail_p10_H2", "location": [ 10, 0, 0.7], "scale": [0.05, 20, 0.05]},
    # Y=-10 edge rails (along X axis)
    {"action": "create_primitive", "primitive": "cube", "object": "Rail_m11_H1", "location": [0, -10, 0.3], "scale": [20, 0.05, 0.05]},
    {"action": "create_primitive", "primitive": "cube", "object": "Rail_m11_H2", "location": [0, -10, 0.7], "scale": [20, 0.05, 0.05]},
    # Y=+10 edge rails
    {"action": "create_primitive", "primitive": "cube", "object": "Rail_p11_H1", "location": [0,  10, 0.3], "scale": [20, 0.05, 0.05]},
    {"action": "create_primitive", "primitive": "cube", "object": "Rail_p11_H2", "location": [0,  10, 0.7], "scale": [20, 0.05, 0.05]},
  ],
  input_blend=null,
  output_blend="/tmp/model-006/step01_geometry.blend"
)
```

**Triangle budget estimate:**
- Ground plane (20×20 quad, 2 tris) = 2
- 16 fence posts (cube, 12 tris each) = 192
- 8 rail beams (cube, 12 tris each) = 96
- **Total: ~290 tris** (well under 500 cap)

### Step 4 — Apply materials

```python
blender_agent_material_pbr_build(
  project_root="/home/rowan/womanvshorseVC",
  material_name="Grass",
  input_blend="/tmp/model-006/step01_geometry.blend",
  output_blend="/tmp/model-006/step02_materials.blend",
  assignments=["GroundPlane"],
  maps=null,
  scalars={"Base Color": [0.298, 0.686, 0.314, 1.0], "Roughness": 0.9, "Metallic": 0.0}
)
```

```python
blender_agent_material_pbr_build(
  project_root="/home/rowan/womanvshorseVC",
  material_name="Wood",
  input_blend="/tmp/model-006/step02_materials.blend",
  output_blend="/tmp/model-006/step02b_materials.blend",
  assignments=["Post_*", "Rail_*"],
  maps=null,
  scalars={"Base Color": [0.475, 0.333, 0.282, 1.0], "Roughness": 0.8, "Metallic": 0.0}
)
```

### Step 5 — UV workflow
```python
blender_agent_uv_workflow(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {"action": "smart_uv_project", "objects": ["GroundPlane", "Post_C00", "Post_C01", "Post_C10", "Post_C11",
               "Post_m10_E", "Post_m10_M", "Post_m10_W", "Post_p10_E", "Post_p10_M", "Post_p10_W",
               "Post_m11_S", "Post_m11_M", "Post_m11_N", "Post_p11_S", "Post_p11_M", "Post_p11_N",
               "Rail_m10_H1", "Rail_m10_H2", "Rail_p10_H1", "Rail_p10_H2",
               "Rail_m11_H1", "Rail_m11_H2", "Rail_p11_H1", "Rail_p11_H2"]},
    {"action": "pack_islands", "settings": {"margin": 0.02}}
  ],
  input_blend="/tmp/model-006/step02b_materials.blend",
  output_blend="/tmp/model-006/step03_uv.blend"
)
```

### Step 6 — Render preview (top-down orthographic)
```python
blender_agent_render_preview(
  project_root="/home/rowan/womanvshorseVC",
  input_blend="/tmp/model-006/step03_uv.blend",
  turntables=null,
  stills=[{"camera": "TOP_DOWN", "output": "/tmp/model-006/preview_topdown.png", "resolution": [512, 512]}],
  output_blend="/tmp/model-006/step04_preview.blend"
)
```

### Step 7 — Quality validate
```python
blender_agent_quality_validate(
  project_root="/home/rowan/womanvshorseVC",
  input_blend="/tmp/model-006/step04_preview.blend",
  profile="game-ready",
  engine="godot",
  checks=["tri_count", "manifold", "normals", "scale"]
)
```
Accept: tri_count ≤ 500, manifold=true, normals=correct, scale=20m×20m ground.

### Step 8 — Export GLB
```python
blender_agent_export_asset(
  project_root="/home/rowan/womanvshorseVC",
  exports=[
    {
      "kind": "GLB",
      "filepath": "assets/models/arena-ground.glb",
      "selection": ["GroundPlane", "Post_C00", "Post_C01", "Post_C10", "Post_C11",
               "Post_m10_E", "Post_m10_M", "Post_m10_W", "Post_p10_E", "Post_p10_M", "Post_p10_W",
               "Post_m11_S", "Post_m11_M", "Post_m11_N", "Post_p11_S", "Post_p11_M", "Post_p11_N",
               "Rail_m10_H1", "Rail_m10_H2", "Rail_p10_H1", "Rail_p10_H2",
               "Rail_m11_H1", "Rail_m11_H2", "Rail_p11_H1", "Rail_p11_H2"]
    }
  ],
  input_blend="/tmp/model-006/step04_preview.blend",
  output_blend="/tmp/model-006/step05_export.blend"
)
```

### Step 9 — Godot certification
```bash
godot4 --headless --path /home/rowan/womanvshorseVC --quit
```

### Step 10 — PROVENANCE.md entry
Append to `assets/PROVENANCE.md`:
```
| arena-ground | 2026-04-17 | MODEL-006 | Blender-MCP chained workflow | assets/models/arena-ground.glb | 290 | CC0 |
```

## 4. Validation Plan

| AC | Check | Evidence |
|---|---|---|
| AC-1: GLB exists | `test -f assets/models/arena-ground.glb` | file exists + size > 0 |
| AC-2: Triangle count ≤ 500 | quality_validate tri_count | ≤ 500 reported |
| AC-3: Manifold, no inverted normals | quality_validate manifold + normals | both PASS |
| AC-4: Godot import | godot4 --headless --quit | exit code 0 |
| AC-5: PROVENANCE.md entry | grep arena-ground assets/PROVENANCE.md | line exists |

## 5. Risks & Assumptions

| Risk | Likelihood | Mitigation |
|---|---|---|
| Triangle budget overrun (290 est. but cube counts can vary) | Low | Monitor quality_validate tri_count output; reduce post count if needed |
| Material assignment by object name glob fails | Medium | Fall back to explicit per-object assignment list or vertex group assignment |
| Plane primitive not flat on XY | Low | Confirm rotation=[0,0,0] after create; add set_transform if needed |
| Blender MCP factory_startup bypasses blend chaining | Low | Verified fixed in MODEL-003/MODEL-004/MODEL-005 chain evidence |

## 6. Blockers / Required Decisions

- **Bootstrap gate**: `blender_agent_environment_probe` must confirm blender binary reachable before Step 1.
- **No other MODEL-006 blockers**: All dependencies (MODEL-001…MODEL-005) are `done/trusted`; lane is `model-generation` and `parallel_safe=true`.
