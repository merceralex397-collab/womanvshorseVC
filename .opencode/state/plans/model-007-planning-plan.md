# Planning Artifact: MODEL-007 — Generate sword-projectile via Blender-MCP

## 1. Scope

Generate `sword-projectile.glb` — a low-poly thrown sword for ranged attack — via Blender-MCP chained workflow. The projectile must read clearly from all rotation angles since it spins in flight. Single solid steel material. Exported GLB placed in `assets/models/`. PROVENANCE.md entry added.

## 2. Files / Systems Affected

- `assets/models/sword-projectile.glb` — output model
- `assets/briefs/sword-projectile.md` — asset brief (created)
- `assets/PROVENANCE.md` — provenance tracking (updated)
- `.blender-mcp/audit/` — audit logs from Blender-MCP calls

## 3. Model Design

### Identity
- **Name**: sword-projectile
- **Category**: prop / weapon
- **Art Style**: low-poly stylized
- **Target Engine**: Godot 4.6
- **Export Format**: .glb (GLTF Binary)

### Visual Description
A elongated dagger/stiletto-style throwing sword. Slim straight blade (~70% of total length) with a short cylindrical handle and small crossguard. Symmetrical along the blade's long axis so it reads clearly during spin. Steel silver throughout. Low-poly with visible facets. No complex materials or textures.

### Technical Constraints
- **Triangle budget**: ≤ 200 tris (hard cap, ~150 target)
- **Texture size**: none (solid color PBR)
- **Material slots**: 1 (steel)
- **UV mapping**: none needed (single solid PBR, no textures)
- **Rigging**: None (static mesh)
- **Animation**: None
- **Scale reference**: 0.9m total length in Godot/Blender units

### Color Palette
- Primary: #B0BEC5 (steel gray, roughness 0.3, metallic 0.9)

## 4. Blender-MCP Tool Sequence

All mutating calls use explicit `input_blend`/`output_blend` chaining. Each step's `output_blend` becomes the next step's `input_blend`.

### Step 1 — project_initialize
```
project_initialize(
  project_root="/home/rowan/womanvshorseVC",
  output_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step1.blend",
  template="empty",
  units="METRIC",
  unit_scale=1.0,
  factory_startup=null
)
```

### Step 2 — scene_batch_edit: blade geometry
Create blade as hexagonal cylinder (low segment count for low poly). Create handle as narrow cylinder. Create crossguard as flat box.

```
scene_batch_edit(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {
      "action": "create_primitive",
      "object": "Blade",
      "primitive": "cylinder",
      "properties": {"radius": 0.015, "depth": 0.65, "vertices": 6}
    },
    {
      "action": "create_primitive",
      "object": "Handle",
      "primitive": "cylinder",
      "properties": {"radius": 0.008, "depth": 0.18, "vertices": 8}
    },
    {
      "action": "create_primitive",
      "object": "Crossguard",
      "primitive": "cube",
      "properties": {"size": [0.06, 0.01, 0.015]}
    },
    {
      "action": "set_transform",
      "object": "Handle",
      "properties": {"location": [0, -0.09, 0]}
    },
    {
      "action": "set_transform",
      "object": "Crossguard",
      "properties": {"location": [0, -0.01, 0]}
    },
    {
      "action": "parent",
      "source": "Handle",
      "target": "Blade"
    },
    {
      "action": "parent",
      "source": "Crossguard",
      "target": "Blade"
    }
  ],
  input_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step1.blend",
  output_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step2.blend"
)
```

### Step 3 — mesh_edit_batch: apply transforms, triangulate, verify
```
mesh_edit_batch(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {"action": "apply_transforms", "object": "Blade"},
    {"action": "triangulate", "object": "Blade"}
  ],
  input_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step2.blend",
  output_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step3.blend"
)
```

### Step 4 — material_pbr_build: steel material
```
material_pbr_build(
  project_root="/home/rowan/womanvshorseVC",
  material_name="Steel",
  assignments=["Blade"],
  scalars={"roughness": 0.3, "metallic": 0.9},
  maps=null,
  input_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step3.blend",
  output_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step4.blend"
)
```

### Step 5 — render_preview: orthographic spin views
Capture 4 cardinal views to verify silhouette readability during spin.
```
render_preview(
  project_root="/home/rowan/womanvshorseVC",
  stills=[
    {"view": "front", "output": ".blender-mcp/captures/sword-projectile-front.png"},
    {"view": "side", "output": ".blender-mcp/captures/sword-projectile-side.png"},
    {"view": "top", "output": ".blender-mcp/captures/sword-projectile-top.png"},
    {"view": "perspective", "output": ".blender-mcp/captures/sword-projectile-persp.png"}
  ],
  input_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step4.blend",
  output_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step5.blend"
)
```

### Step 6 — quality_validate
```
quality_validate(
  project_root="/home/rowan/womanvshorseVC",
  input_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step5.blend",
  profile="game-ready",
  engine="godot"
)
```

Checks: tri count ≤ 200, manifold, no inverted normals, scale ≈ 0.9m.

### Step 7 — export_asset
```
export_asset(
  project_root="/home/rowan/womanvshorseVC",
  exports=[
    {
      "name": "sword-projectile",
      "type": "GLB",
      "path": "assets/models/sword-projectile.glb",
      "format": "GLB"
    }
  ],
  input_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step5.blend",
  output_blend="/home/rowan/womanvshorseVC/.blender-mcp/staging/model-007-step6.blend"
)
```

## 5. Acceptance Criteria Mapping

| # | Criterion | Verification |
|---|-----------|--------------|
| AC-1 | `assets/models/sword-projectile.glb` exists | `ls assets/models/sword-projectile.glb` |
| AC-2 | Triangle count ≤ 200 | quality_validate output tri count |
| AC-3 | Manifold mesh, no inverted normals | quality_validate mesh_check |
| AC-4 | Imports into Godot without errors | `godot4 --headless --path . --quit` EXIT:0 |
| AC-5 | PROVENANCE.md entry added | `grep sword-projectile assets/PROVENANCE.md` |

## 6. Validation Plan

1. Run Blender-MCP chained workflow (steps 1–7 above)
2. After export: `ls -la assets/models/sword-projectile.glb` confirm file exists
3. After export: `grep sword-projectile assets/PROVENANCE.md` confirm provenance entry
4. Run `godot4 --headless --path . --quit` to confirm Godot import clean
5. quality_validate output confirms ≤ 200 tris and manifold

## 7. Risks / Assumptions

| Risk | Likelihood | Mitigation |
|------|-------------|------------|
| Tri count exceeds 200 on first try | Low | Target 150; decimates if needed via mesh_edit_batch decimate |
| Blade not readable from all spin angles | Low | Hexagonal cylinder provides 6-sided silhouette; verify in render_preview |
| Blender MCP blend chaining breaks | Low | Per MODEL-003/MODEL-004 pattern; audit log confirms non-null blend paths |
| PROVENANCE.md format conflict | Low | Follow existing MODEL-* entry pattern |

## 8. Blockers

None. Bootstrap is ready (bootstrap status: ready per workflow-state). MODEL-003 proved Blender-MCP chaining works. VISUAL-001 wired player scene with GLTFDocument loading pattern.
