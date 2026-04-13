# Planning Artifact: MODEL-003 — Generate horse-black via Blender-MCP

## 1. Scope and Objective

**Objective**: Generate a low-poly black horse enemy model (`horse-black.glb`) via Blender-MCP, export to `assets/models/`, and update provenance tracking.

**Deliverable**: `assets/models/horse-black.glb` — a sleek black horse, slimmer than `horse-brown.glb`, with longer legs, narrower body, swept-back mane/tail, and red eye accents. ≤2000 triangles, manifold, Godot-import-clean.

**Wave/Lane**: Wave 1, model-generation lane  
**Parallel safety**: `parallel_safe: true` — model generation is independent of other lanes  
**Overlap risk**: `low` — Blender-MCP model generation touches no shared write surfaces

---

## 2. Files / Surfaces Affected

### Created
| File | Purpose |
|---|---|
| `assets/models/horse-black.glb` | Primary deliverable — exported GLB binary |
| `assets/models/horse-black.blend` | Staging blend file (intermediate, kept for audit) |
| `assets/PROVENANCE.md` | Updated with horse-black entry |

### Modified
| File | Purpose |
|---|---|
| `assets/PROVENANCE.md` | Append horse-black entry |

### Read-Only Inputs (not modified)
| File | Purpose |
|---|---|
| `assets/briefs/horse-black.md` | Asset brief / source of truth for this model |
| `assets/models/horse-brown.glb` | Reference for proportions (slimmer than brown) |
| `docs/spec/CANONICAL-BRIEF.md` | Project constraints |
| `.opencode/skills/stack-standards/SKILL.md` | Blender-MCP and Godot validation rules |

---

## 3. Step-by-Step Implementation

### Step 0 — Pre-flight environment probe
- **Action**: Call `blender_agent_environment_probe` with `project_root: /home/pc/projects/womanvshorseVC`, `include_addon_scan: false`
- **Purpose**: Confirm Blender binary at `/home/pc/blender-4.5.0/blender` is reachable and returns version info
- **Pass condition**: Probe returns success with Blender version information

### Step 1 — Initialize clean Blender scene
- **Action**: Call `blender_agent_project_initialize`
  - `project_root: /home/pc/projects/womanvshorseVC`
  - `output_blend: assets/models/horse-black.blend`
  - `template: empty`
  - `units: METRIC`
  - `unit_scale: 1`
  - `fps: 24`
- **Purpose**: Create a clean staging file with metric units
- **Pass condition**: Blend file created at target path

### Step 2 — Build horse geometry (low-poly body)
- **Action**: Call `blender_agent_scene_batch_edit` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-black.blend`, `output_blend: assets/models/horse-black.blend`
- **Operations**:
  1. `create_primitive` — cube, name: `BodyBarrel`, scale ~0.45 x 0.35 x 0.9 (narrower/longer than brown horse barrel)
  2. `set_transform` — position BodyBarrel at y=0.7
  3. `create_primitive` — cube scaled 0.18 x 0.48 x 0.18, name: `FL_Leg` (front-left), slightly longer than brown horse
  4. `set_transform` — position FL_Leg at x=-0.2, z=0.35, y=0.24
  5. Repeat leg creation for FR, BL, BR legs — all slightly longer than brown horse legs
  6. `create_primitive` — cube scaled 0.25 x 0.35 x 0.3, name: `Neck`; position at front-top of barrel, angled forward ~20°
  7. `create_primitive` — cube scaled 0.2 x 0.25 x 0.35, name: `Head`; position at front-top of neck, angled forward ~10°
  8. `create_primitive` — tapered series of 4 flat thin cubes for `Mane` along neck, swept back
  9. `create_primitive` — series of 3 flat thin cubes for `Tail`, swept back from rear
  10. `join` — all primitives into single mesh
  11. `set_origin` — to world y=0 (ground level)
- **Pass condition**: Single joined mesh exists in scene

### Step 3 — Refine joint detail and eye indentations
- **Action**: Call `blender_agent_scene_batch_edit` with same blend paths
- **Operations**:
  1. `set_transform` — shape hooves: scale bottom of each leg 0.16 x 0.08 x 0.16
  2. `set_transform` — narrow the barrel further: scale x 0.42 (slimmer than brown)
  3. `create_primitive` — two tiny planes for `EyeLeft` and `EyeRight` on head sides, inset slightly
  4. `move_to_collection` — create/move to `horse_black` collection
- **Pass condition**: Mesh structure matches asset brief proportions (sleeker silhouette than brown)

### Step 4 — Apply transforms and mesh cleanup
- **Action**: Call `blender_agent_mesh_edit_batch` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-black.blend`, `output_blend: assets/models/horse-black.blend`
- **Operations**:
  1. `apply_transforms` — apply all location/rotation/scale to mesh
  2. `recalculate_normals` — fix normals direction
  3. `delete_loose` — remove any stray vertices
  4. `triangulate` — convert any ngons to triangles
- **Pass condition**: Mesh is manifold, normals outward, no loose geometry

### Step 5 — Create PBR materials
- **Action**: Call `blender_agent_material_pbr_build` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-black.blend`, `output_blend: assets/models/horse-black.blend`
- **Material 1 — BlackBody**:
  - `material_name: BlackBody`
  - `assignments: ["BodyBarrel", "FL_Leg", "FR_Leg", "BL_Leg", "BR_Leg", "Neck", "Head", "Mane", "Tail"]`
  - `scalars: { "Roughness": 0.5, "Metallic": 0.1 }`
  - Color: base color #1A1A1A (near-black)
- **Material 2 — RedEyes**:
  - `material_name: RedEyes`
  - `assignments: ["EyeLeft", "EyeRight"]`
  - `scalars: { "Roughness": 0.2, "Metallic": 0.0, "Emission Strength": 0.5 }`
  - Color: #FF2222 (red)
- **Pass condition**: Two material slots assigned to correct mesh regions; red eyes have subtle emission

### Step 6 — UV unwrapping
- **Action**: Call `blender_agent_uv_workflow` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-black.blend`, `output_blend: assets/models/horse-black.blend`
- **Operations**:
  1. `unwrap` — smart UV project with island margin 0.02
  2. `pack_uv_islands` — pack with 0.02 padding
- **Pass condition**: UV islands non-overlapping, packed within 0-1 space

### Step 7 — Render preview
- **Action**: Call `blender_agent_render_preview` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-black.blend`, `output_blend: assets/models/horse-black.blend`
- **Stills**:
  1. Front orthographic view, transparent background, 512x512
  2. Side orthographic view, transparent background, 512x512
- **Pass condition**: Preview images saved; visually distinct dark sleek silhouette, red eye accents visible

### Step 8 — Quality validation
- **Action**: Call `blender_agent_quality_validate` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-black.blend`, `profile: game-ready`, `engine: godot`
- **Checks**:
  - Triangle count ≤ 2000
  - Manifold mesh (watertight)
  - No inverted normals
  - Scale check: height ~1.5m at head
- **Pass condition**: All checks return PASS

### Step 9 — Export GLB
- **Action**: Call `blender_agent_export_asset` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-black.blend`
- **Exports**:
  - `filepath: assets/models/horse-black.glb`
  - `format: gltf/glb`
  - `export_parameters: { apply_modifiers: true }`
- **Pass condition**: `assets/models/horse-black.glb` created, file size > 0

### Step 10 — Godot import validation
- **Action**: Run `/home/pc/.local/bin/godot --headless --path /home/pc/projects/womanvshorseVC --quit`
- **Pass condition**: Godot starts without import errors, no Output panel errors related to horse-black.glb

### Step 11 — Update PROVENANCE.md
- **Action**: Append row to `assets/PROVENANCE.md`:
  ```
  | assets/models/horse-black.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-10 |
  ```
- **Pass condition**: PROVENANCE.md contains horse-black entry

---

## 4. Quality Validation Plan

| Acceptance Criterion | Validation Method | Pass Evidence |
|---|---|---|
| AC-1: `assets/models/horse-black.glb` exists | File existence check `ls -la assets/models/horse-black.glb` | File present, size > 0 |
| AC-2: Triangle count ≤ 2000 | `blender_agent_quality_validate` tri_count check | PASS in quality_validate output |
| AC-3: Manifold mesh, no inverted normals | `blender_agent_quality_validate` manifold + normals checks | PASS in quality_validate output |
| AC-4: Imports into Godot without errors | `godot --headless --path . --quit` | No Error entries in Output panel |
| AC-5: PROVENANCE.md entry added | Read `assets/PROVENANCE.md` | horse-black.glb row present |

**Bonus visual checks** (from asset brief):
- Sleeker silhouette than brown horse (longer legs, narrower barrel) — confirmed in geometry ops Steps 2-3
- Red eye accents visible — confirmed in Step 5 (RedEyes material with emission) and Step 7 (render_preview)
- Height ~1.5m at head — confirmed in Step 8 (scale check via quality_validate)

---

## 5. Risks and Assumptions

| Risk | Likelihood | Mitigation |
|---|---|---|
| Triangle count exceeds 2000 budget | Medium | Monitor tri count after geometry steps; use `decimate` modifier or reduce leg/neck detail if approaching budget |
| Mesh not manifold after join | Low | Run `merge_by_distance` at 0.001 before triangulate; verify with quality_validate |
| Blender MCP server unavailable | Low | Pre-flight probe in Step 0 catches this; return blocker if server not reachable |
| Godot import fails on black material | Low | Ensure GLB exports with PBR materials correctly; verify material slots in quality_validate |
| Horse not visually distinct from brown | Medium | Reference horse-brown proportions; confirm sleeker silhouette in render_preview Step 7 |
| Normal direction issues after export | Low | Recalculate normals before export; verify with quality_validate |

**Assumptions**:
- Blender MCP server is running and reachable at `/home/pc/blender-4.5.0/blender`
- Godot binary at `/home/pc/.local/bin/godot` is functional (validated via REMED-001)
- `assets/briefs/horse-black.md` is the authoritative brief and does not need updating
- `horse-brown.glb` exists and can be used as a visual reference for proportions

---

## 6. Decision Blockers

**None currently.** All required inputs are available:
- Blender binary: available (confirmed by prior model generation tickets)
- Asset brief: `assets/briefs/horse-black.md` exists and is complete
- Output path: `assets/models/` exists and is writable
- Godot binary: available and validated (per REMED-001 smoke-test)

---

## 7. Acceptance Criteria Mapping

| # | Acceptance Criterion | Step(s) that satisfy it |
|---|---|---|
| 1 | `assets/models/horse-black.glb` exists | Step 9 (export) — file created |
| 2 | Triangle count ≤ 2000 | Step 8 (quality_validate) — explicit PASS |
| 3 | Manifold mesh, no inverted normals | Step 8 (quality_validate) — explicit PASS; Step 4 (mesh cleanup) |
| 4 | Imports into Godot without errors | Step 10 (godot headless validation) |
| 5 | PROVENANCE.md entry added | Step 11 (append to PROVENANCE.md) |

---

*Plan produced by wvhvc-planner for MODEL-003. Planning artifact only — no implementation, review, or Blender execution performed.*
