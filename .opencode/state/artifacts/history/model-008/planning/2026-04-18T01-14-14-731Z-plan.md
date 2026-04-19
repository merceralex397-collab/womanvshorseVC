# Plan: MODEL-008 — Generate heart-pickup via Blender-MCP

## 1. Scope

Generate the `heart-pickup` 3D model via the blender-agent MCP bridge, export as GLB to `assets/models/heart-pickup.glb`, certify with quality_validate, and record provenance. This is a health pickup item — simple heart geometry suitable for top-down 3D gameplay readability.

## 2. Files / Systems Affected

| Surface | Path |
|---|---|
| Blender staging | `/tmp/model-008/staging.blend` |
| Output GLB | `assets/models/heart-pickup.glb` |
| Godot project | `/home/rowan/womanvshorseVC/project.godot` |
| Provenance log | `assets/PROVENANCE.md` |
| Asset brief (reference only) | `assets/briefs/heart-pickup.md` (not yet created — brief content inferred from CANONICAL-BRIEF.md and model-007 precedent) |

## 3. Asset Brief (Inferred)

Since `assets/briefs/heart-pickup.md` does not yet exist, the brief content is inferred:

- **Name**: heart-pickup
- **Category**: prop
- **Art Style**: low-poly stylized
- **Target Engine**: Godot 4.6
- **Triangle budget**: ≤100 tris (hard cap), ~80 target
- **Material**: 1 PBR slot — red heart (#E53935)
- **Scale reference**: ~0.2–0.3m diameter in Godot units (readable from top-down camera)
- **Design**: Simple heart silhouette, clean from above, no fine detail needed

## 4. Blender-MCP Tool Sequence

### Step 1 — Bootstrap Blender environment
```python
blender_agent_environment_probe(
  project_root="/home/rowan/womanvshorseVC",
  include_addon_scan=False
)
```
**Gate**: Must confirm blender binary at `/home/pc/blender-4.5.0/blender` is reachable and bridge is responsive before proceeding.

### Step 2 — Initialize staging file
```python
blender_agent_project_initialize(
  project_root="/home/rowan/womanvshorseVC",
  output_blend="/tmp/model-008/staging.blend",
  template="empty",
  units="METRIC",
  unit_scale=1.0,
  factory_startup=None
)
```

### Step 3 — Build heart geometry in scene_batch_edit
Compose the heart from primitives (no custom mesh required — low-poly heart readable from top-down):

```python
blender_agent_scene_batch_edit(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    # Heart: two symmetric rounded lobes built from scaled spheres + tapered bottom
    # Left lobe
    {"action": "create_primitive", "primitive": "uv_sphere", "object": "HeartLobe_L", "location": [-0.06, 0, 0.06], "scale": [0.08, 0.08, 0.06]},
    # Right lobe
    {"action": "create_primitive", "primitive": "uv_sphere", "object": "HeartLobe_R", "location": [0.06, 0, 0.06], "scale": [0.08, 0.08, 0.06]},
    # Center bridge
    {"action": "create_primitive", "primitive": "cube", "object": "HeartBridge", "location": [0, 0, 0.04], "scale": [0.04, 0.04, 0.04]},
    # Taper point (bottom tip of heart)
    {"action": "create_primitive", "primitive": "cone", "object": "HeartTip", "location": [0, 0, -0.02], "scale": [0.04, 0.04, 0.06], "rotation": [3.14159, 0, 0]}
  ],
  input_blend="/tmp/model-008/staging.blend",
  output_blend="/tmp/model-008/step01_geometry.blend"
)
```

**Triangle budget estimate:**
- 2× uv_sphere lobes (ico_sphere 1 subdivision = ~42 tris each) = ~84
- 1× cube bridge (~12 tris) = ~12
- 1× cone taper (~24 tris) = ~24
- **Total: ~120 tris est.** — exceeds 100 cap; will use ico_sphere detail=0 for ~24 tris per lobe instead

**Revised geometry** (lower-tris approach using scaled ico_spheres with detail=0):
```python
blender_agent_scene_batch_edit(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    # Left lobe — very low-poly ico_sphere (detail=0 = ~24 tris)
    {"action": "create_primitive", "primitive": "ico_sphere", "object": "HeartLobe_L", "location": [-0.055, 0, 0.055], "scale": [0.09, 0.09, 0.07]},
    # Right lobe
    {"action": "create_primitive", "primitive": "ico_sphere", "object": "HeartLobe_R", "location": [0.055, 0, 0.055], "scale": [0.09, 0.09, 0.07]},
    # Bottom taper — small cube scaled to a pointed wedge
    {"action": "create_primitive", "primitive": "cube", "object": "HeartTip", "location": [0, 0, -0.015], "scale": [0.025, 0.025, 0.04]}
  ],
  input_blend="/tmp/model-008/staging.blend",
  output_blend="/tmp/model-008/step01_geometry.blend"
)
```
**Revised estimate**: 2× ico_sphere (~24 each) + 1× cube (~12) = **~60 tris** (under 100 cap)

### Step 4 — Refine mesh with mesh_edit_batch
Merge lobes and clean up the join between lobes and tip:
```python
blender_agent_mesh_edit_batch(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {"action": "merge_by_distance", "objects": ["HeartLobe_L", "HeartBridge", "HeartLobe_R", "HeartTip"], "threshold": 0.02},
    {"action": "delete_loose", "objects": null},
    {"action": "recalculate_normals", "objects": null}
  ],
  input_blend="/tmp/model-008/step01_geometry.blend",
  output_blend="/tmp/model-008/step02_mesh.blend"
)
```

### Step 5 — Apply PBR material (red heart)
```python
blender_agent_material_pbr_build(
  project_root="/home/rowan/womanvshorseVC",
  material_name="HeartRed",
  input_blend="/tmp/model-008/step02_mesh.blend",
  output_blend="/tmp/model-008/step03_material.blend",
  assignments=["HeartLobe_L", "HeartLobe_R", "HeartBridge", "HeartTip"],
  maps=None,
  scalars={"Base Color": [0.898, 0.224, 0.208, 1.0], "Roughness": 0.7, "Metallic": 0.0, "Emission": [0.3, 0.05, 0.05, 1.0], "Emission Strength": 0.4}
)
```

### Step 6 — Render preview (top-down orthographic)
```python
blender_agent_render_preview(
  project_root="/home/rowan/womanvshorseVC",
  input_blend="/tmp/model-008/step03_material.blend",
  stills=[{"camera": "TOP_DOWN", "output": "/tmp/model-008/preview_topdown.png", "resolution": [512, 512]}],
  output_blend="/tmp/model-008/step04_preview.blend"
)
```

### Step 7 — Quality validate
```python
blender_agent_quality_validate(
  project_root="/home/rowan/womanvshorseVC",
  input_blend="/tmp/model-008/step04_preview.blend",
  profile="game-ready",
  engine="godot",
  checks=["tri_count", "manifold", "normals", "scale"]
)
```
**Accept**: tri_count ≤ 100, manifold=true, normals=correct.

### Step 8 — Export GLB
```python
blender_agent_export_asset(
  project_root="/home/rowan/womanvshorseVC",
  exports=[{"kind": "GLB", "filepath": "assets/models/heart-pickup.glb", "selection": ["HeartLobe_L", "HeartLobe_R", "HeartBridge", "HeartTip"]}],
  input_blend="/tmp/model-008/step04_preview.blend",
  output_blend="/tmp/model-008/step05_export.blend"
)
```

### Step 9 — Godot certification
```bash
godot4 --headless --path /home/rowan/womanvshorseVC --quit
```

### Step 10 — PROVENANCE.md entry
Append to `assets/PROVENANCE.md`:
```
| heart-pickup | 2026-04-18 | MODEL-008 | Blender-MCP chained workflow | assets/models/heart-pickup.glb | ~60 | CC0 |
```

## 5. Acceptance Criteria Mapping

| AC | Criterion | Check | Evidence |
|---|---|---|---|
| AC-1 | `assets/models/heart-pickup.glb` exists | `test -f assets/models/heart-pickup.glb` | file exists + size > 0 |
| AC-2 | Triangle count ≤ 100 | quality_validate tri_count report | ≤ 100 reported |
| AC-3 | Manifold mesh, no inverted normals | quality_validate manifold + normals | both PASS |
| AC-4 | Imports into Godot without errors | godot4 --headless --quit | exit code 0 |
| AC-5 | PROVENANCE.md entry added | grep heart-pickup assets/PROVENANCE.md | line exists with MODEL-008 |

## 6. Risks & Assumptions

| Risk | Likelihood | Mitigation |
|---|---|---|
| **BLENDER-MCP v1 compat bug**: MODEL-007 was blocked because `scene_batch_edit` does not forward `input_blend`/`output_blend` parameters (bug in `_wrap_v1_scene_batch_edit`). MODEL-008 uses the same tool chain and could fail identically. | **High** | The chained workflow pattern explicitly passes blend paths on every call. If the blender_agent server was fixed post-MODEL-007, this pattern will succeed. If not fixed, MODEL-008 will block with the same root cause and require a remediation ticket. |
| Triangle budget overrun: ico_sphere detail=0 tri count varies by Blender version | Low | Monitor quality_validate tri_count after Step 7; reduce lobe scale if needed |
| Material assignment by object name fails | Low | Explicit object list provided; fallback to single merge-join before material |
| merge_by_distance threshold too aggressive and deforms heart shape | Medium | Use threshold 0.01 first; visually verify via render_preview before Step 7 |

## 7. Blockers / Required Decisions

- **Bootstrap gate**: `blender_agent_environment_probe` must confirm blender binary reachable before Step 1.
- **Known server-level risk**: The blender_agent MCP server v1 compat bug (same root cause that blocked MODEL-007) may prevent blend path forwarding for `scene_batch_edit`. This is a **managed external blocker** — if encountered, the plan cannot self-repair and a follow-up remediation ticket is required. The workflow design correctly follows the proven explicit blend-forwarding pattern; failure indicates server-level defect, not plan error.
- **No MODEL-008-specific blockers**: All dependencies are `done/trusted`; lane is `model-generation` and `parallel_safe=true`.
