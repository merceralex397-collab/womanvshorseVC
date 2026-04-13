# Planning Artifact: MODEL-002 — Generate horse-brown via Blender-MCP

## 1. Scope

Generate a low-poly 3D brown horse character model via Blender-MCP, export as GLB to `assets/models/horse-brown.glb`, and track provenance. This is the basic enemy type appearing in large groups throughout waves.

## 2. Files / Systems Affected

| Item | Path | Action |
|------|------|--------|
| Blender binary | `/home/pc/blender-4.5.0/blender` | Execution environment |
| MCP server | `/home/pc/projects/blender-agent/mcp-server` | Tool host |
| Asset brief | `assets/briefs/horse-brown.md` | Source of truth for model spec |
| Output model | `assets/models/horse-brown.glb` | Generated artifact |
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
- Create torso from a **cube** primitive, scaled to barrel shape (wider than tall, ~1.0m wide, ~0.8m tall, ~1.5m long)
- Extrude **4 legs** downward from torso base (cylindrical shape, ~0.3m diameter, ~0.8m long each)
- Extrude **neck** forward and upward from front of torso (tapered, ~0.4m wide at base, ~0.6m long, angled ~45° upward)
- Extrude **head** as tapered box from neck end (~0.3m wide, ~0.4m long, ~0.3m tall, wedge shape pointing forward)

### Step 4 — Mesh Build: Refine (Second mesh_edit_batch)
Call `mesh_edit_batch` to refine and detail:
- Add **loop cuts** at leg joints (knees) and neck base for bend flexibility
- Shape **hooves** as flattened cylinders at leg bottoms (~0.05m flat disk)
- Extrude **mane** as flat strip along top of neck (~0.1m wide, ~0.5m long, dark brown material)
- Extrude **tail** as tapered flat strip from rear of torso (~0.15m wide at top, tapers to point, ~0.8m long, dark brown material)
- Ensure overall dimensions are **1.5m tall at head**, **2.0m long nose-to-tail**
- **Do not exceed 2000 triangles total** — monitor cumulative count carefully (tighter budget than MODEL-001)

### Step 5 — Session Checkpoint
Call `blender_session_snapshot` with include_captures=`true` before material work to preserve modeling state.

### Step 6 — Material PBR Build
Call `material_pbr_build` to create 2 material slots:

| Slot | Name | Base Color | Roughness | Metallic |
|------|------|------------|-----------|----------|
| 1 | Brown Body | `#8B4513` | 0.7 | 0.0 |
| 2 | Dark Mane/Tail | `#2F1B0E` | 0.8 | 0.0 |

Assign materials to face selections:
- Slot 1 (brown body) → torso, legs, neck, head, hooves
- Slot 2 (dark mane/tail) → mane strip, tail strip

### Step 7 — UV Workflow
Call `uv_workflow`:
- **method**: `smart_uv_project`
- **pack_islands**: `true`
- Verify UV islands are non-overlapping

### Step 8 — Session Checkpoint
Call `blender_session_snapshot` with include_captures=`true` before rendering.

### Step 9 — Render Preview
Call `render_preview`:
- **stills**: front orthographic + side orthographic
- **background**: `transparent`
- Output to project render directory
- Review renders to confirm:
  - Barrel-shaped body visible and readable from top-down
  - 4 legs clearly visible in silhouette
  - Head/neck profile readable from side
  - Mane and tail distinct from body color
  - Proportions ~1.5m tall at head, ~2.0m long

### Step 10 — Quality Validate
Call `quality_validate`:
- **max_triangles**: `2000`
- **expected_scale**: `1.5` (meters at head)
- **checks**: `["triangle_count", "manifold", "normals", "scale", "uv_overlap"]`

If validation fails, return to Step 4 to fix issues.

### Step 11 — Export Asset
Call `export_asset`:
- **format**: `glb`
- **output_path**: `assets/models/horse-brown.glb`
- **apply_modifiers**: `true`
- **include_materials**: `true`
- **include_uv**: `true`

### Step 12 — Godot Import Validation
1. Run Godot headless validation: `godot --headless --path . --quit`
2. Verify `horse-brown.glb` appears in FileSystem if imported manually
3. Check for any import errors in Output panel
4. Confirm model reads as a horse from top-down orthographic view

### Step 13 — Provenance Update
Append to `assets/PROVENANCE.md`:

```markdown
| assets/models/horse-brown.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | YYYY-MM-DD |
```

Replace `YYYY-MM-DD` with today's date.

## 4. Validation Plan

| Acceptance Criterion | Validation Method |
|---------------------|-------------------|
| `assets/models/horse-brown.glb` exists | `ls -la assets/models/horse-brown.glb` |
| Triangle count ≤ 2000 | `quality_validate` output: `triangle_count` field |
| Manifold mesh | `quality_validate`: `manifold` == `true` |
| No inverted normals | `quality_validate`: `normals` == `valid` |
| Imports into Godot without errors | Godot Output panel clean, no red errors |
| PROVENANCE.md entry added | `grep horse-brown assets/PROVENANCE.md` |

## 5. Risks and Assumptions

| Risk | Mitigation |
|------|------------|
| Triangle budget exceeded during refinement (2000 is stricter than MODEL-001's 3000) | Monitor count after each mesh_edit_batch; simplify loop cuts or dissolve edges if approaching 2000; prioritize silhouette over detail |
| Non-manifold geometry from extrusions | Keep extrusions clean; avoid internal faces; verify with `quality_validate` before export |
| Horse shape not readable from top-down | Ensure barrel body and 4-leg spread are clearly visible in orthographic renders; verify in quality_validate |
| Mane/tail material bleeding into body | Use distinct material slots with sharp boundaries; no smooth transitions between slots |
| Godot material import issues | Use Principled BSDF only (no complex shaders); keep material node tree simple |
| Server session loss | Use `blender_session_snapshot` between major steps; can recover from last checkpoint |

**Assumptions:**
- Blender 4.5.0 binary at `/home/pc/blender-4.5.0/blender` is functional
- MCP server at `/home/pc/projects/blender-agent/mcp-server` is reachable
- `assets/models/` directory already exists (or will be auto-created by export)
- MODEL-001 precedent confirms the tool sequence and workflow is stable

## 6. Blockers / Required Decisions

- **None identified** — All required tools, paths, and specs are defined in the canonical brief and skill.
- If `project_initialize` fails, treat as environment blocker and escalate before proceeding.
- If triangle count exceeds 2000 after initial build, prioritize body silhouette over leg joint detail.
