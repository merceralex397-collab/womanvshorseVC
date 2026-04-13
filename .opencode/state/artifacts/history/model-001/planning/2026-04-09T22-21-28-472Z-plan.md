# Planning Artifact: MODEL-001 — Generate woman-warrior via Blender-MCP

## 1. Scope

Generate a low-poly 3D warrior woman character model via Blender-MCP, export as GLB to `assets/models/woman-warrior.glb`, and track provenance.

## 2. Files / Systems Affected

| Item | Path | Action |
|------|------|--------|
| Blender binary | `/home/pc/blender-4.5.0/blender` | Execution environment |
| MCP server | `/home/pc/projects/blender-agent/mcp-server` | Tool host |
| Asset brief | `assets/briefs/woman-warrior.md` | Source of truth for model spec |
| Output model | `assets/models/woman-warrior.glb` | Generated artifact |
| Provenance log | `assets/PROVENANCE.md` | Append generation record |
| Godot project | `.` | Import validation |

## 3. Implementation Steps

### Step 1 — Session Setup
1. Ensure the Blender-MCP server is running:
   ```bash
   cd /home/pc/projects/blender-agent/mcp-server && python3 -m blender_mcp_server
   ```
2. Verify MCP tools are available: `project_initialize`, `mesh_edit_batch`, `material_pbr_build`, `uv_workflow`, `render_preview`, `quality_validate`, `export_asset`.

### Step 2 — Project Initialize
Call `project_initialize`:
- **new_file**: `true`
- **units**: `metric` (1 unit = 1 meter)
- **cleanup_default**: `true` (remove default cube/camera/light)

### Step 3 — Mesh Build: Body (First mesh_edit_batch)
Call `mesh_edit_batch` to construct the base body from primitives:
- Create torso from a **cube** primitive, scaled to approximate a warrior's torso
- Extrude **legs** (two rectangular extrusions downward from torso base)
- Extrude **arms** (two rectangular extrusions outward/upward from torso sides)
- Create **neck** (small cylinder or cube extrusion upward)
- Create **head** (slightly enlarged cube or sphere for stylized proportions)
- Create **sword** (thin rectangular extrusion extending from right hand area, ~0.8m long)

### Step 4 — Mesh Build: Refine (Second mesh_edit_batch)
Call `mesh_edit_batch` to refine and detail:
- Add **loop cuts** at joints: elbows, knees, waist for bend flexibility
- Shape **head** into simplified face wedge — blocky, readable from top-down
- Add **shoulder plate** geometry — small raised box shapes on both shoulders
- Shape **hair** as an extruded wedge from back/top of head, swept back
- Ensure overall height is **1.7m** (adjust cube/primitive scales as needed)
- **Do not exceed 3000 triangles total** — monitor cumulative count

### Step 5 — Session Checkpoint
Call `blender_session_checkpoint` with name `"modeling-complete"` before material work.

### Step 6 — Material PBR Build
Call `material_pbr_build` to create 3 material slots:

| Slot | Name | Base Color | Roughness | Metallic |
|------|------|------------|-----------|----------|
| 1 | Green Armor | `#2E7D32` | 0.6 | 0.3 |
| 2 | Silver Sword/Plates | `#C0C0C0` | 0.3 | 0.8 |
| 3 | Skin | `#FFCCBC` | 0.8 | 0.0 |

Assign materials to face selections:
- Slot 1 (green armor) → torso, shoulder plates, skirt/tunic
- Slot 2 (silver) → sword blade
- Slot 3 (skin) → face, arms, neck

### Step 7 — UV Workflow
Call `uv_workflow`:
- **method**: `smart_uv_project`
- **pack_islands**: `true`
- Verify UV islands are non-overlapping

### Step 8 — Session Checkpoint
Call `blender_session_checkpoint` with name `"materials-complete"` before rendering.

### Step 9 — Render Preview
Call `render_preview`:
- **views**: `["front_orthographic", "side_orthographic"]`
- **background**: `transparent`
- Output to project render directory
- Review renders to confirm:
  - Green armor clearly visible from top-down
  - Sword silhouette readable from above
  - Head/hair wedge shape visible
  - Proportions ~1.7m tall

### Step 10 — Quality Validate
Call `quality_validate`:
- **max_triangles**: `3000`
- **expected_scale**: `1.7` (meters)
- **checks**: `["triangle_count", "manifold", "normals", "scale", "uv_overlap"]`

If validation fails, return to Step 4 to fix issues.

### Step 11 — Export Asset
Call `export_asset`:
- **format**: `glb`
- **output_path**: `assets/models/woman-warrior.glb`
- **apply_modifiers**: `true`
- **include_materials**: `true`
- **include_uv**: `true`

### Step 12 — Godot Import Validation
1. Open the Godot project
2. Verify `woman-warrior.glb` appears in the FileSystem dock
3. Check the Output panel for import errors
4. Instance the model in a test scene to confirm it loads correctly

### Step 13 — Provenance Update
Append to `assets/PROVENANCE.md`:

```markdown
| assets/models/woman-warrior.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | YYYY-MM-DD |
```

Replace `YYYY-MM-DD` with today's date.

## 4. Validation Plan

| Acceptance Criterion | Validation Method |
|---------------------|-------------------|
| `assets/models/woman-warrior.glb` exists | `ls -la assets/models/woman-warrior.glb` |
| Triangle count ≤ 3000 | `quality_validate` output: `triangle_count` field |
| Manifold mesh | `quality_validate`: `manifold` == `true` |
| No inverted normals | `quality_validate`: `normals` == `valid` |
| Imports into Godot without errors | Godot Output panel clean, no red errors |
| PROVENANCE.md entry added | `grep woman-warrior assets/PROVENANCE.md` |

## 5. Risks and Assumptions

| Risk | Mitigation |
|------|------------|
| Triangle budget exceeded during refinement | Monitor count after each mesh_edit_batch; simplify loop cuts or dissolve edges if approaching 3000 |
| Non-manifold geometry from extrusions | Keep extrusions clean; avoid internal faces; verify with `quality_validate` before export |
| Godot material import issues | Use Principled BSDF only (no complex shaders); keep material node tree simple |
| Server session loss | Use `blender_session_checkpoint` between major steps; can recover from last checkpoint |

**Assumptions:**
- Blender 4.5.0 binary at `/home/pc/blender-4.5.0/blender` is functional
- MCP server at `/home/pc/projects/blender-agent/mcp-server` is reachable
- `assets/models/` directory already exists (or will be auto-created by export)

## 6. Blockers / Required Decisions

- **None identified** — All required tools, paths, and specs are defined in the canonical brief and skill.
- If `project_initialize` fails, treat as environment blocker and escalate before proceeding.
