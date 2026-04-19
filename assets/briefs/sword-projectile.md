# Asset Brief: Sword Projectile

## Identity
- **Name**: sword-projectile
- **Category**: prop
- **Art Style**: low-poly stylized
- **Target Engine**: Godot 4.6
- **Export Format**: .glb (GLTF Binary)

## Visual Description
A throwable sword for the warrior's ranged attack. Low-poly with visible facets. Symmetrical blade design for consistent spin during flight. Simple crossguard, straight grip, and rounded pommel. Steel material with slight roughness for visual readability. Designed to be recognizable as a blade from any rotation during flight.

## Technical Constraints
- **Triangle budget**: 200 tris (hard cap)
- **Texture size**: 512x512 max (single material)
- **Material slots**: 1 (steel blade)
- **UV mapping**: Auto-unwrap (Smart UV Project)
- **Rigging**: None (static mesh)
- **Animation**: None
- **Scale reference**: 0.9m total length in Godot/Blender units

## Color Palette
- Primary: #C0C0C0 (steel/silver blade)
- Accent: #A0A0A0 (blade edge highlight)

## Blender-MCP Tool Sequence
1. project_initialize — new file, metric units, clean scene
2. scene_batch_edit — create blade as elongated diamond/hexagonal prism, crossguard as thin box perpendicular to blade, handle as cylinder, pommel as small sphere
3. mesh_edit_batch — refine blade edges, add slight bevel at crossguard junction
4. material_pbr_build — steel blade (#C0C0C0, roughness 0.4, metallic 0.9)
5. uv_workflow — smart UV project, pack islands
6. render_preview — front + side orthographic, transparent background
7. quality_validate — check tri count ≤ 200, manifold, no inverted normals, scale ~0.9m
8. export_asset — .glb to assets/models/sword-projectile.glb, apply modifiers

## Acceptance Criteria
- [ ] Triangle count ≤ 200
- [ ] No inverted normals
- [ ] Manifold mesh (watertight)
- [ ] UV islands non-overlapping
- [ ] Length approximately 0.9m total
- [ ] Symmetrical blade design (readable from any rotation)
- [ ] Preview renders reviewed
- [ ] Materials match color palette
- [ ] Imports cleanly into Godot (no Output panel errors)
- [ ] PROVENANCE.md entry created
