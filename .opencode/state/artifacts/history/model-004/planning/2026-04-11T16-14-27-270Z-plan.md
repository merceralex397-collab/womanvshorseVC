# Planning Artifact: MODEL-004 — Generate horse-war via Blender-MCP

## 1. Scope and Objective

**Objective**: Generate a low-poly armored war horse model (`horse-war.glb`) via Blender-MCP, export to `assets/models/`, and update provenance tracking.

**Deliverable**: `assets/models/horse-war.glb` — an armored war horse with bulkier proportions than standard horses, plate armor on head (chamfron), chest (peytral), and flanks, red/gray color scheme. ≤4000 triangles, manifold, Godot-import-clean.

**Wave/Lane**: Wave 1, model-generation lane
**Parallel safety**: `parallel_safe: true` — model generation is independent of other lanes
**Overlap risk**: `low` — Blender-MCP model generation touches no shared write surfaces

---

## 2. Files / Surfaces Affected

### Created
| File | Purpose |
|---|---|
| `assets/models/horse-war.glb` | Primary deliverable — exported GLB binary |
| `assets/models/horse-war.blend` | Staging blend file (intermediate, kept for audit) |
| `assets/PROVENANCE.md` | Updated with horse-war entry |

### Modified
| File | Purpose |
|---|---|
| `assets/PROVENANCE.md` | Append horse-war entry |

### Read-Only Inputs (not modified)
| File | Purpose |
|---|---|
| `assets/briefs/horse-war.md` | Asset brief / source of truth for this model |
| `assets/models/horse-brown.glb` | Reference for proportions (bulkier than brown) |
| `docs/spec/CANONICAL-BRIEF.md` | Project constraints |
| `.opencode/skills/stack-standards/SKILL.md` | Blender-MCP and Godot validation rules |

---

## 3. Known Blender-MCP Constraints (Workaround Plan)

The Blender MCP bridge has documented issues that must be accounted for:

| Issue | Impact | Workaround |
|---|---|---|
| `scene_batch_edit` uses `--factory-startup` which causes `input_loaded: false` on subsequent calls | State is lost between calls unless `output_blend` is specified | **Always provide `output_blend` parameter** pointing to the same file as `input_blend` to preserve state across calls |
| `create_primitive` auto-names objects as `Cube.XXX` / `Cylinder.XXX` ignoring the `object` parameter | Cannot name objects directly | **Accept auto-generated names** (Cube, Cube.001, Cylinder, etc.) and reference them by those names in subsequent operations |
| `output_blend=null` never persists scene state | Any call without `output_blend` loses changes | **Never omit `output_blend`** when persistence is required |

**Strategy**: Each Blender MCP call will include `output_blend: assets/models/horse-war.blend` matching its `input_blend` to maintain state. Objects will be tracked by their auto-generated names as observed in MODEL-002.

---

## 4. Step-by-Step Implementation

### Step 0 — Pre-flight environment probe
- **Action**: Call `blender_agent_environment_probe` with `project_root: /home/pc/projects/womanvshorseVC`, `include_addon_scan: false`
- **Purpose**: Confirm Blender binary at `/home/pc/blender-4.5.0/blender` is reachable and returns version info
- **Pass condition**: Probe returns success with Blender version information

### Step 1 — Initialize clean Blender scene
- **Action**: Call `blender_agent_project_initialize`
  - `project_root: /home/pc/projects/womanvshorseVC`
  - `output_blend: assets/models/horse-war.blend`
  - `template: empty`
  - `units: METRIC`
  - `unit_scale: 1`
  - `fps: 24`
  - `factory_startup: true` (required for clean scene)
- **Purpose**: Create a clean staging file with metric units
- **Pass condition**: Blend file created at target path

### Step 2 — Build war horse body geometry (bulkier proportions)
- **Action**: Call `blender_agent_scene_batch_edit` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-war.blend`, `output_blend: assets/models/horse-war.blend`
- **Operations** (objects will auto-name as Cube, Cylinder, etc.):
  1. `create_primitive` — cube, primitive: cube, scale ~0.7 x 0.55 x 1.0 (wider/bulkier than standard horse barrel)
  2. `set_transform` — position BodyBarrel at y=0.75
  3. `create_primitive` — cube scaled 0.22 x 0.55 x 0.22, primitive: cube (thicker front-left leg)
  4. `set_transform` — position FL_Leg at x=-0.28, z=0.38, y=0.275
  5. Repeat leg creation for FR, BL, BR legs — all thicker than standard horse legs
  6. `create_primitive` — cube scaled 0.3 x 0.45 x 0.35, name: Neck; position at front-top of barrel, angled forward ~20°
  7. `create_primitive` — cube scaled 0.28 x 0.3 x 0.4, name: Head; position at front-top of neck, angled forward ~10°
  8. `create_primitive` — series of 3 flat thin cubes for `Tail`, short and thick
- **Pass condition**: 10+ primitive objects exist in scene

### Step 3 — Add armor plate geometry (chamfron, peytral, flanks, shoulders)
- **Action**: Call `blender_agent_scene_batch_edit` with same blend paths
- **Operations**:
  1. `create_primitive` — cube scaled 0.35 x 0.35 x 0.08, name: `Chamfron` (head armor plate)
  2. `set_transform` — position Chamfron at front of head, angled with head
  3. `create_primitive` — cube scaled 0.75 x 0.5 x 0.15, name: `Peytral` (chest armor)
  4. `set_transform` — position Peytral at front of barrel chest area
  5. `create_primitive` — cube scaled 0.12 x 0.45 x 0.25, name: `FL_Flank` (front-left flank armor)
  6. `set_transform` — position FL_Flank at x=-0.35, side of barrel
  7. Repeat flank armor for FR, BL, BR positions
  8. `create_primitive` — cube scaled 0.3 x 0.25 x 0.12, name: `ShoulderPlateL` (left shoulder guard)
  9. `set_transform` — position at top-front-left of barrel
  10. `create_primitive` — cube scaled 0.3 x 0.25 x 0.12, name: `ShoulderPlateR` (right shoulder guard)
  11. `set_transform` — position at top-front-right of barrel
  12. `move_to_collection` — create/move to `horse_war` collection
- **Pass condition**: Armor plate primitives added to scene

### Step 4 — Create 3 PBR materials (body, armor, trim)
- **Action**: Call `blender_agent_material_pbr_build` (x3 calls) with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-war.blend`, `output_blend: assets/models/horse-war.blend`
- **Material 1 — GrayBody**:
  - `material_name: GrayBody`
  - `assignments: ["BodyBarrel", all leg cubes, Neck, Head, Tail]` (auto-generated names)
  - `scalars: { "Roughness": 0.7, "Metallic": 0.0 }`
  - Color: #4A4A4A (gray horse body)
- **Material 2 — RedArmor**:
  - `material_name: RedArmor`
  - `assignments: ["Chamfron", "Peytral", "FL_Flank", "FR_Flank", "BL_Flank", "BR_Flank", "ShoulderPlateL", "ShoulderPlateR"]`
  - `scalars: { "Roughness": 0.4, "Metallic": 0.5 }`
  - Color: #CC2222 (dark red armor)
- **Material 3 — DarkTrim**:
  - `material_name: DarkTrim`
  - `assignments: ["mane cubes if created separately"]`
  - `scalars: { "Roughness": 0.3, "Metallic": 0.6 }`
  - Color: #8B0000 (dark red trim)
- **Pass condition**: Three material slots assigned; body is gray, armor is red, trim is dark red

### Step 5 — UV unwrapping
- **Action**: Call `blender_agent_uv_workflow` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-war.blend`, `output_blend: assets/models/horse-war.blend`
- **Operations**:
  1. `unwrap` — smart UV project with island margin 0.02
  2. `pack_uv_islands` — pack with 0.02 padding
- **Pass condition**: UV islands non-overlapping, packed within 0-1 space

### Step 6 — Join all geometry and apply transforms
- **Action**: Call `blender_agent_scene_batch_edit` with same blend paths
- **Operations**:
  1. `join` — all armor plate primitives into single mesh (armor join first)
  2. `join` — all body primitives (legs, barrel, neck, head, tail) 
  3. `join` — armor mesh + body mesh
  4. `set_origin` — to world y=0 (ground level)
- **Pass condition**: Single joined mesh exists in scene

### Step 7 — Mesh cleanup and optimization
- **Action**: Call `blender_agent_mesh_edit_batch` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-war.blend`, `output_blend: assets/models/horse-war.blend`
- **Operations**:
  1. `apply_transforms` — apply all location/rotation/scale to mesh
  2. `recalculate_normals` — fix normals direction
  3. `delete_loose` — remove any stray vertices
  4. `triangulate` — convert any ngons to triangles
- **Pass condition**: Mesh is manifold, normals outward, no loose geometry

### Step 8 — Quality validation
- **Action**: Call `blender_agent_quality_validate` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-war.blend`, `profile: game-ready`, `engine: godot`
- **Checks**:
  - Triangle count ≤ 4000
  - Manifold mesh (watertight)
  - No inverted normals
  - Scale check: height ~1.7m at head
- **Pass condition**: All checks return PASS

### Step 9 — Export GLB
- **Action**: Call `blender_agent_export_asset` with `project_root: /home/pc/projects/womanvshorseVC`, `input_blend: assets/models/horse-war.blend`
- **Exports**:
  - `filepath: assets/models/horse-war.glb`
  - `format: gltf/glb`
  - `export_parameters: { apply_modifiers: true }`
- **Pass condition**: `assets/models/horse-war.glb` created, file size > 0

### Step 10 — Godot import validation
- **Action**: Call `blender_agent_quality_validate` with engine: godot (already done in Step 8)
- **Pass condition**: Godot certification PASS in quality_validate output

### Step 11 — Update PROVENANCE.md
- **Action**: Append row to `assets/PROVENANCE.md`:
  ```
  | assets/models/horse-war.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-11 |
  ```
- **Pass condition**: PROVENANCE.md contains horse-war entry

---

## 5. Quality Validation Plan

| Acceptance Criterion | Validation Method | Pass Evidence |
|---|---|---|
| AC-1: `assets/models/horse-war.glb` exists | File existence check | File present, size > 0 |
| AC-2: Triangle count ≤ 4000 | `blender_agent_quality_validate` tri_count check | PASS in quality_validate output |
| AC-3: Manifold mesh, no inverted normals | `blender_agent_quality_validate` manifold + normals checks | PASS in quality_validate output |
| AC-4: Imports into Godot without errors | `blender_agent_quality_validate` with engine: godot | Godot certification: PASSED |
| AC-5: PROVENANCE.md entry added | Read `assets/PROVENANCE.md` | horse-war.glb row present |

**Visual checks** (from asset brief):
- Bulkier proportions than standard horses (wider barrel, thicker legs) — confirmed in geometry ops Step 2
- Armor plates visible (chamfron, peytral, flanks) — confirmed in Step 3
- Red/gray color scheme distinct from brown and black variants — confirmed in Step 4
- Height ~1.7m at head — confirmed in Step 8 (scale check via quality_validate)

---

## 6. Risks and Assumptions

| Risk | Likelihood | Mitigation |
|---|---|---|
| Triangle count exceeds 4000 budget (higher than standard horses but still constrained) | Medium | Monitor tri count after geometry steps; use `decimate` modifier if approaching budget |
| Mesh not manifold after join | Low | Run `merge_by_distance` at 0.001 before triangulate; verify with quality_validate |
| Blender MCP server unavailable | Low | Pre-flight probe in Step 0 catches this; return blocker if server not reachable |
| Armor plates not visually distinct from body in Godot import | Medium | Ensure materials are correctly assigned by checking assignments in Step 4 |
| Normal direction issues after export | Low | Recalculate normals before export; verify with quality_validate |
| Factory-startup state loss between calls | High (known issue) | Always provide `output_blend` matching `input_blend`; accept auto-generated object names |

**Assumptions**:
- Blender MCP server is running and reachable at `/home/pc/blender-4.5.0/blender`
- `assets/briefs/horse-war.md` is the authoritative brief and does not need updating
- `horse-brown.glb` exists and can be used as a visual reference for proportions
- Godot headless validation is functional (per REMED-001/REMED-002 validation)

---

## 7. Decision Blockers

**None currently.** All required inputs are available:
- Blender binary: available (confirmed by prior model generation tickets)
- Asset brief: `assets/briefs/horse-war.md` exists and is complete
- Output path: `assets/models/` exists and is writable
- Blender MCP bridge workarounds: planned (always use `output_blend`, accept auto-generated names)

---

## 8. Acceptance Criteria Mapping

| # | Acceptance Criterion | Step(s) that satisfy it |
|---|---|---|
| 1 | `assets/models/horse-war.glb` exists | Step 9 (export) — file created |
| 2 | Triangle count ≤ 4000 | Step 8 (quality_validate) — explicit PASS |
| 3 | Manifold mesh, no inverted normals | Step 8 (quality_validate) — explicit PASS; Step 7 (mesh cleanup) |
| 4 | Imports into Godot without errors | Step 10 (quality_validate with godot engine) |
| 5 | PROVENANCE.md entry added | Step 11 (append to PROVENANCE.md) |

---

## 9. Triangle Budget Allocation

War horse is larger and more detailed than standard horses. Budget: 4000 tris.

| Part | Estimated Tris | Notes |
|---|---|---|
| Body barrel | ~400 | Wider than standard horse |
| 4 thick legs | ~320 | 4 × ~80 each |
| Neck + Head | ~200 | Blocky, armored |
| Tail | ~40 | Short and thick |
| Chamfron (head armor) | ~80 | Angular plate |
| Peytral (chest armor) | ~120 | Large chest plate |
| 4 flank armor plates | ~240 | 4 × ~60 each |
| 2 shoulder plates | ~100 | Angular shoulder guards |
| **Total estimated** | **~1500** | Well under 4000 budget |

Note: Final triangle count may be higher due to armor plate geometry complexity. Quality validation in Step 8 will confirm actual count.

---

*Plan produced by wvhvc-planner for MODEL-004. Planning artifact only — no implementation, review, or Blender execution performed.*
