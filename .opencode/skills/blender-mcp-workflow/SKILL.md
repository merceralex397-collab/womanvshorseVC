---
name: blender-mcp-workflow
description: How to use the blender-agent MCP server to generate 3D models from asset briefs. Use when a ticket requires creating or updating a 3D model via Blender-MCP tools.
---

# Blender-MCP Workflow

Before using this workflow, call `skill_ping` with `skill_id: "blender-mcp-workflow"` and `scope: "project"`.

## Server Configuration

- **Server location**: `/home/pc/projects/blender-agent`
- **Start command**: `cd /home/pc/projects/blender-agent/mcp-server && python3 -m blender_mcp_server`
- **Blender binary**: `/home/pc/blender-4.5.0/blender`
- **Protocol**: MCP (Model Context Protocol) over stdio
- **Session**: Requires an active Blender session via the MCP add-on

## Available Tools

### Core Pipeline Tools (use in this order)

1. **`project_initialize`** — Create a new Blender project file with correct units and settings
   - Sets metric units, 1 unit = 1 meter
   - Cleans default cube/camera/light
   - Creates project directory structure

2. **`mesh_edit_batch`** — Create and modify mesh geometry
   - Create primitives (cube, sphere, cylinder, plane)
   - Extrude, inset, loop cut, bevel
   - Scale, rotate, move vertices/edges/faces
   - Boolean operations for complex shapes
   - Use for building character/prop shapes from primitives

3. **`material_pbr_build`** — Create PBR materials from color palette
   - Base color from hex values in asset brief
   - Roughness, metallic, emission values
   - Assign materials to mesh face selections
   - Multiple material slots per object

4. **`uv_workflow`** — UV unwrap and pack
   - Smart UV Project (good for low-poly)
   - Pack Islands for texture atlas efficiency
   - Mark seams if needed for specific unwrap control

5. **`render_preview`** — Generate preview renders for validation
   - Orthographic front/side/3-quarter views
   - Transparent background for asset review
   - Output to project render directory

6. **`quality_validate`** — Check mesh quality against budget
   - Triangle count vs budget from asset brief
   - Manifold check (watertight mesh)
   - Normal direction check (no inverted normals)
   - Scale verification (matches Godot units)
   - UV overlap check

7. **`export_asset`** — Export to GLB for Godot import
   - GLTF Binary (.glb) format
   - Apply all modifiers before export
   - Include materials and UV maps
   - Godot-compatible settings (Y-up, meters)
   - Output to `assets/models/<asset-name>.glb`

### Session Management Tools

- **`blender_session_create`** — Start a new Blender session
- **`blender_session_attach`** — Attach to an existing session
- **`blender_session_close`** — Clean up and close
- **`blender_session_checkpoint`** — Save named checkpoint (use between major steps)

### Additional Tools

- **`scene_query`** — Inspect current scene objects and properties
- **`scene_batch_edit`** — Batch scene operations
- **`modifier_stack_edit`** — Add/configure modifiers (subdivision, mirror, etc.)
- **`addon_configure`** — Enable/disable Blender add-ons

## Standard Asset Generation Sequence

For each asset brief in `assets/briefs/<name>.md`:

```
1. Read the asset brief completely
2. project_initialize — new .blend file for this asset
3. mesh_edit_batch — build base shape from primitives
4. mesh_edit_batch — refine shape (loop cuts, extrusions, detail)
5. blender_session_checkpoint — save "modeling-complete"
6. material_pbr_build — create materials from brief color palette
7. uv_workflow — smart UV project, pack islands
8. blender_session_checkpoint — save "materials-complete"
9. render_preview — front + side orthographic renders
10. quality_validate — check against brief constraints
11. IF validation fails: fix issues and re-validate
12. export_asset — GLB to assets/models/<name>.glb
13. Update assets/PROVENANCE.md with generation record
```

## Asset Brief → Tool Parameter Mapping

The asset brief fields map directly to tool parameters:

| Brief Field | Tool | Parameter |
|---|---|---|
| Triangle budget | quality_validate | max_triangles |
| Color Palette primary | material_pbr_build | base_color |
| Color Palette secondary | material_pbr_build | base_color (slot 2) |
| Export Format | export_asset | format="glb" |
| Scale reference | quality_validate | expected_scale |
| Material slots | material_pbr_build | slot_count |

## Provenance Tracking

After successful export, add an entry to `assets/PROVENANCE.md`:

```markdown
| assets/models/<name>.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | YYYY-MM-DD |
```

## Validation Checklist (per model)

- [ ] Triangle count within brief budget
- [ ] No inverted normals (quality_validate)
- [ ] Manifold mesh / watertight (quality_validate)
- [ ] UV islands non-overlapping (quality_validate)
- [ ] Correct scale — 1 Blender unit = 1 Godot unit = 1 meter
- [ ] Materials assigned with correct colors from brief palette
- [ ] Preview renders match visual description in brief
- [ ] GLB exports without errors
- [ ] GLB imports into Godot without errors (check Output panel)
- [ ] PROVENANCE.md entry created

## Error Recovery

- **Session lost**: Use `blender_session_create` to start fresh. Checkpoints allow partial recovery.
- **Triangle budget exceeded**: Use `mesh_edit_batch` to dissolve edges, merge vertices, or simplify geometry. Re-run `quality_validate`.
- **Export fails**: Check for non-manifold geometry, unapplied modifiers, or scale issues. Fix and retry.
- **Godot import errors**: Usually caused by unsupported material nodes or non-standard UV. Re-export with simpler material setup.

## Constraints

- One model per Blender session (clean project per asset)
- Always checkpoint before destructive operations
- GLB only — do not export FBX, OBJ, or other formats
- All models must be static (no armature/animation) unless brief explicitly requires it
- Keep material node trees simple — Principled BSDF only, no complex shader networks
