# Planning — MODEL-005: Generate horse-boss via Blender-MCP

## Status: PLANNING

## Scope

**Ticket:** MODEL-005  
**Title:** Generate horse-boss via Blender-MCP  
**Wave:** 1  
**Lane:** model-generation  
**Summary:** Generate boss horse model via blender-agent MCP following `assets/briefs/horse-boss.md`. Export GLB to `assets/models/`.  
**Triangle budget:** ≤ 5000 (hard cap, 1.3x scale of standard horses)  
**Scale reference:** 2.2m tall at head, 2.8m long in Godot/Blender units  

---

## Visual Design

Boss horse — large, imposing, ornate gold armor:
- **Stance:** Rearing-ready, four legs planted (stable for game AI)
- **Body:** Dark charcoal (#2C2C2C) under armor
- **Armor:** Gold (#FFD700) chest plate (peytral), head armor (chamfron), crown crest, back plates, leg greaves
- **Trim:** Dark goldenrod (#B8860B) for armor trim and details
- **Eyes:** Glowing red emissive accent for boss menacing feel
- **Distinction:** Crown crest on head readable from top-down orthographic camera

---

## Implementation Steps

### Step 0 — Environment Bootstrap
- Run `environment_bootstrap` to verify Blender MCP and Godot headless are available
- Confirm `/home/pc/blender-4.5.0/blender` is accessible and version 4.5.0
- Confirm `godot4 --headless --path /home/rowan/womanvshorseVC --quit` exits cleanly
- Verify `project.godot` contains `textures/vram_compression/import_etc2_astc=true`

### Step 1 — Project Initialize (staging file creation)
```
blender_agent_project_initialize(
  project_root="/home/rowan/womanvshorseVC",
  output_blend="horse-boss-stage1.blend",
  units="METRIC",
  unit_scale=1.0
)
```
- Creates clean Blender scene with metric units
- Response must include `persistence.saved_blend` for chaining

### Step 2 — Build Large Body (primitives, 1.3x scale)
```
blender_agent_scene_batch_edit(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {"action": "create_primitive", "object": "BodyMain", "primitive": "cube", "collection": "BossHorse"},
    {"action": "set_transform", "object": "BodyMain", "scale": [1.3, 1.0, 1.8]},
    {"action": "create_primitive", "object": "Neck", "primitive": "cylinder", "collection": "BossHorse"},
    {"action": "set_transform", "object": "Neck", "scale": [0.5, 0.8, 0.5], "location": [0, 0.9, 1.2]},
    {"action": "create_primitive", "object": "Head", "primitive": "cube", "collection": "BossHorse"},
    {"action": "set_transform", "object": "Head", "scale": [0.6, 0.6, 0.9], "location": [0, 1.5, 1.5]},
    {"action": "create_primitive", "object": "LegFL", "primitive": "cylinder", "collection": "BossHorse"},
    {"action": "set_transform", "object": "LegFL", "scale": [0.35, 1.2, 0.35], "location": [0.6, -0.7, 0.9]},
    {"action": "create_primitive", "object": "LegFR", "primitive": "cylinder", "collection": "BossHorse"},
    {"action": "set_transform", "object": "LegFR", "scale": [0.35, 1.2, 0.35], "location": [-0.6, -0.7, 0.9]},
    {"action": "create_primitive", "object": "LegBL", "primitive": "cylinder", "collection": "BossHorse"},
    {"action": "set_transform", "object": "LegBL", "scale": [0.35, 1.2, 0.35], "location": [0.6, -0.7, -0.9]},
    {"action": "create_primitive", "object": "LegBR", "primitive": "cylinder", "collection": "BossHorse"},
    {"action": "set_transform", "object": "LegBR", "scale": [0.35, 1.2, 0.35], "location": [-0.6, -0.7, -0.9]},
    {"action": "create_primitive", "object": "Tail", "primitive": "cylinder", "collection": "BossHorse"},
    {"action": "set_transform", "object": "Tail", "scale": [0.15, 1.0, 0.15], "location": [0, 0.0, -2.0], "rotation": [0.3, 0, 0]}
  ],
  input_blend="horse-boss-stage1.blend",
  output_blend="horse-boss-stage2.blend"
)
```
- Creates 8 body part primitives at 1.3x scale relative to standard horse
- All parts separate for individual shaping and armor placement

### Step 3 — Shape Body Parts (scales and transforms refinement)
```
blender_agent_scene_batch_edit(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {"action": "set_transform", "object": "BodyMain", "scale": [1.3, 0.95, 1.85]},
    {"action": "set_transform", "object": "Neck", "scale": [0.55, 0.95, 0.55], "location": [0, 1.0, 1.3], "rotation": [-0.2, 0, 0]},
    {"action": "set_transform", "object": "Head", "scale": [0.65, 0.65, 1.0], "location": [0, 1.65, 1.6], "rotation": [-0.15, 0, 0]},
    {"action": "set_transform", "object": "LegFL", "scale": [0.38, 1.25, 0.38], "location": [0.65, -0.75, 0.9]},
    {"action": "set_transform", "object": "LegFR", "scale": [0.38, 1.25, 0.38], "location": [-0.65, -0.75, 0.9]},
    {"action": "set_transform", "object": "LegBL", "scale": [0.38, 1.25, 0.38], "location": [0.65, -0.75, -0.9]},
    {"action": "set_transform", "object": "LegBR", "scale": [0.38, 1.25, 0.38], "location": [-0.65, -0.75, -0.9]},
    {"action": "set_transform", "object": "Tail", "scale": [0.18, 1.2, 0.18], "location": [0, 0.1, -2.1], "rotation": [0.35, 0, 0]}
  ],
  input_blend="horse-boss-stage2.blend",
  output_blend="horse-boss-stage3.blend"
)
```
- Refine proportions for boss horse bulkier appearance

### Step 4 — Join Body Parts
```
blender_agent_scene_batch_edit(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {"action": "join", "objects": ["BodyMain", "Neck", "Head", "LegFL", "LegFR", "LegBL", "LegBR", "Tail"]}
  ],
  input_blend="horse-boss-stage3.blend",
  output_blend="horse-boss-stage4.blend"
)
```
- Joins all body parts into single mesh for final shaping

### Step 5 — Build Armor Geometry (chamfron, peytral, crown crest, greaves)
```
blender_agent_scene_batch_edit(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {"action": "create_primitive", "object": "ChestArmor", "primitive": "cube", "collection": "BossArmor"},
    {"action": "set_transform", "object": "ChestArmor", "scale": [1.1, 0.8, 0.5], "location": [0, 0.3, 1.2], "rotation": [0, 0, 0]},
    {"action": "create_primitive", "object": "HeadArmor", "primitive": "cube", "collection": "BossArmor"},
    {"action": "set_transform", "object": "HeadArmor", "scale": [0.7, 0.5, 0.8], "location": [0, 1.7, 1.6], "rotation": [0, 0, 0]},
    {"action": "create_primitive", "object": "CrownCrest", "primitive": "cone", "collection": "BossArmor"},
    {"action": "set_transform", "object": "CrownCrest", "scale": [0.4, 0.5, 0.4], "location": [0, 2.1, 1.6], "rotation": [0, 0, 0]},
    {"action": "create_primitive", "object": "BackPlate1", "primitive": "cube", "collection": "BossArmor"},
    {"action": "set_transform", "object": "BackPlate1", "scale": [1.0, 0.3, 0.4], "location": [0, 0.6, 0.0]},
    {"action": "create_primitive", "object": "BackPlate2", "primitive": "cube", "collection": "BossArmor"},
    {"action": "set_transform", "object": "BackPlate2", "scale": [0.9, 0.3, 0.4], "location": [0, 0.5, -0.5]},
    {"action": "create_primitive", "object": "GreaveFL", "primitive": "cylinder", "collection": "BossArmor"},
    {"action": "set_transform", "object": "GreaveFL", "scale": [0.45, 0.9, 0.45], "location": [0.65, -0.5, 0.9]},
    {"action": "create_primitive", "object": "GreaveFR", "primitive": "cylinder", "collection": "BossArmor"},
    {"action": "set_transform", "object": "GreaveFR", "scale": [0.45, 0.9, 0.45], "location": [-0.65, -0.5, 0.9]},
    {"action": "create_primitive", "object": "GreaveBL", "primitive": "cylinder", "collection": "BossArmor"},
    {"action": "set_transform", "object": "GreaveBL", "scale": [0.45, 0.9, 0.45], "location": [0.65, -0.5, -0.9]},
    {"action": "create_primitive", "object": "GreaveBR", "primitive": "cylinder", "collection": "BossArmor"},
    {"action": "set_transform", "object": "GreaveBR", "scale": [0.45, 0.9, 0.45], "location": [-0.65, -0.5, -0.9]}
  ],
  input_blend="horse-boss-stage4.blend",
  output_blend="horse-boss-stage5.blend"
)
```
- Creates ornate armor pieces separate from body for material assignment

### Step 6 — Add Glowing Red Eyes (emissive accent)
```
blender_agent_scene_batch_edit(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {"action": "create_primitive", "object": "EyeL", "primitive": "uv_sphere", "collection": "BossEyes"},
    {"action": "set_transform", "object": "EyeL", "scale": [0.08, 0.08, 0.08], "location": [0.2, 1.7, 2.0]},
    {"action": "create_primitive", "object": "EyeR", "primitive": "uv_sphere", "collection": "BossEyes"},
    {"action": "set_transform", "object": "EyeR", "scale": [0.08, 0.08, 0.08], "location": [-0.2, 1.7, 2.0]}
  ],
  input_blend="horse-boss-stage5.blend",
  output_blend="horse-boss-stage6.blend"
)
```
- Small emissive spheres for menacing glowing eyes

### Step 7 — Merge Geometry and Finalize Transforms
```
blender_agent_scene_batch_edit(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {"action": "join", "objects": ["BodyMain", "Neck", "Head", "LegFL", "LegFR", "LegBL", "LegBR", "Tail", "ChestArmor", "HeadArmor", "CrownCrest", "BackPlate1", "BackPlate2", "GreaveFL", "GreaveFR", "GreaveBL", "GreaveBR"]},
    {"action": "join", "objects": ["EyeL", "EyeR"]}
  ],
  input_blend="horse-boss-stage6.blend",
  output_blend="horse-boss-stage7.blend"
)
```
- All body parts merged into single Body mesh; eyes merged into separate Eyes mesh

### Step 8 — Mesh Cleanup (triangulate, fix normals, apply transforms)
```
blender_agent_mesh_edit_batch(
  project_root="/home/rowan/womanvshorseVC",
  operations=[
    {"action": "triangulate"},
    {"action": "recalculate_normals"},
    {"action": "apply_transforms"}
  ],
  input_blend="horse-boss-stage7.blend",
  output_blend="horse-boss-stage8.blend"
)
```

### Step 9 — Material: Dark Body (#2C2C2C)
```
blender_agent_material_pbr_build(
  project_root="/home/rowan/womanvshorseVC",
  material_name="DarkBody",
  assignments=["Body"],
  maps=null,
  scalars={"Base Color": [0.173, 0.173, 0.173, 1.0], "Roughness": 0.6, "Metallic": 0.0},
  input_blend="horse-boss-stage8.blend",
  output_blend="horse-boss-stage9.blend"
)
```
- Dark charcoal body material, roughness 0.6, non-metallic

### Step 10 — Material: Gold Armor (#FFD700)
```
blender_agent_material_pbr_build(
  project_root="/home/rowan/womanvshorseVC",
  material_name="GoldArmor",
  assignments=["Eyes"],
  maps=null,
  scalars={"Base Color": [1.0, 0.843, 0.0, 1.0], "Roughness": 0.3, "Metallic": 0.8},
  input_blend="horse-boss-stage9.blend",
  output_blend="horse-boss-stage10.blend"
)
```
- Gold armor with metallic 0.8, low roughness 0.3

### Step 11 — Material: Red Eyes (Emissive)
```
blender_agent_material_pbr_build(
  project_root="/home/rowan/womanvshorseVC",
  material_name="RedEyes",
  assignments=["Eyes"],
  maps=null,
  scalars={"Base Color": [0.8, 0.0, 0.0, 1.0], "Roughness": 0.5, "Metallic": 0.0, "Emission": [1.0, 0.0, 0.0], "Emission Strength": 2.0},
  input_blend="horse-boss-stage10.blend",
  output_blend="horse-boss-stage11.blend"
)
```
- Glowing red emissive eyes for boss menacing presence

### Step 12 — Quality Validate (game_asset profile)
```
blender_agent_quality_validate(
  project_root="/home/rowan/womanvshorseVC",
  input_blend="horse-boss-stage11.blend",
  profile="game_asset",
  engine="godot",
  checks=["mesh_integrity", "material_readiness", "object_naming", "engine_target"]
)
```
- Must show 0 errors before export
- Triangle count must be ≤ 5000

### Step 13 — Scene Query (verify triangle count)
```
blender_agent_scene_query(
  project_root="/home/rowan/womanvshorseVC",
  input_blend="horse-boss-stage11.blend"
)
```
- Confirm total triangle count ≤ 5000

### Step 14 — Export GLB
```
blender_agent_export_asset(
  project_root="/home/rowan/womanvshorseVC",
  exports=[
    {
      "filepath": "assets/models/horse-boss.glb",
      "format": "glb",
      "selection": "all"
    }
  ],
  input_blend="horse-boss-stage11.blend"
)
```
- Exports to `assets/models/horse-boss.glb`

### Step 15 — Godot Headless Validation
```
godot4 --headless --path /home/rowan/womanvshorseVC --quit
```
- Must exit cleanly (exit code 0)
- Confirms project.godot is valid and Android VRAM settings present

### Step 16 — PROVENANCE.md Entry
Add entry to `assets/PROVENANCE.md`:
```
| assets/models/horse-boss.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-17 |
```

---

## Blender MCP Chain Summary

| Step | Tool | input_blend | output_blend |
|---|---|---|---|
| 1 | project_initialize | null | stage1 |
| 2 | scene_batch_edit (body primitives) | stage1 | stage2 |
| 3 | scene_batch_edit (refine transforms) | stage2 | stage3 |
| 4 | scene_batch_edit (join body) | stage3 | stage4 |
| 5 | scene_batch_edit (armor pieces) | stage4 | stage5 |
| 6 | scene_batch_edit (eyes) | stage5 | stage6 |
| 7 | scene_batch_edit (merge all) | stage6 | stage7 |
| 8 | mesh_edit_batch | stage7 | stage8 |
| 9 | material_pbr_build (DarkBody) | stage8 | stage9 |
| 10 | material_pbr_build (GoldArmor) | stage9 | stage10 |
| 11 | material_pbr_build (RedEyes) | stage10 | stage11 |
| 12 | quality_validate | stage11 | stage11 |
| 13 | scene_query | stage11 | stage11 |
| 14 | export_asset | stage11 | horse-boss.glb |

---

## Quality Validation

### Pre-Export (Blender-side)
- `quality_validate` with `profile=game_asset`, `engine=godot`
- Checks: mesh_integrity, material_readiness, object_naming, engine_target
- Triangle count via `scene_query` on final blend

### Post-Export (Godot-side)
- `godot4 --headless --path /home/rowan/womanvshorseVC --quit`
- Confirms project.godot is valid
- Confirms `textures/vram_compression/import_etc2_astc=true` present

---

## Acceptance Criteria Mapping

| AC | Verification | Pass Condition |
|---|---|---|
| AC-1: `assets/models/horse-boss.glb` exists | `ls -la assets/models/horse-boss.glb` | File exists, size > 0 |
| AC-2: Triangle count ≤ 5000 | `scene_query` on stage11.blend | triangles ≤ 5000 |
| AC-3: Manifold mesh, no inverted normals | `quality_validate` (mesh_integrity) | errors=0, warnings=0 |
| AC-4: Imports into Godot without errors | Godot headless + `quality_validate` engine_target | exit code 0, godot cert PASS |
| AC-5: PROVENANCE.md entry added | `grep horse-boss assets/PROVENANCE.md` | Entry exists with date |

---

## Risks and Assumptions

1. **Triangle budget risk:** Boss horse with ornate armor (chamfron, peytral, crown crest, greaves) may approach 5000 cap. Mitigation: monitor tri count at step 12; decimate if needed via `mesh_edit_batch` decimate action.
2. **Material assignment risk:** Join order must produce separate Body and Eyes meshes for material targeting. Verification: confirm `scene_query` shows correct material assignments before material_pbr_build calls.
3. **Emissive eyes risk:** Emission Strength 2.0 may be too bright for Godot. Mitigation: reduce to 1.0-1.5 if Godot certification warns about emissive intensity.
4. **Bootstrap assumption:** Blender MCP bridge is functioning; chain pattern from MODEL-003/MODEL-004 confirmed working. If any call returns `input_loaded: false`, abort and file defect ticket.

---

## Blockers

- **BLOCKER-1:** Bootstrap environment_bootstrap fails — cannot proceed until Blender MCP and Godot headless are verified
- **BLOCKER-2:** Triangle count exceeds 5000 after quality_validate step — must decimate before export
- **BLOCKER-3:** Any `scene_batch_edit` call returns `input_loaded: false` — indicates bridge chaining failure; file remediation ticket

---

## Decision Blockers

None. All decisions from CANONICAL-BRIEF.md and assets/briefs/horse-boss.md are resolved:
- Blender-MCP route confirmed (used successfully in MODEL-003/MODEL-004)
- Low-poly style confirmed
- 3-material PBR confirmed
- Godot 4.6 export target confirmed
