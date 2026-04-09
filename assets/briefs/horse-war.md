# Asset Brief: War Horse

## Identity
- **Name**: horse-war
- **Category**: character
- **Art Style**: low-poly stylized
- **Target Engine**: Godot 4.6
- **Export Format**: .glb (GLTF Binary)

## Visual Description
An armored war horse standing on four legs in a wide aggressive stance. Low-poly with visible facets. Bulkier proportions than standard horses — wider body, thicker legs. Wears plate armor on the head (chamfron), chest (peytral), and flanks. Armor plates are angular flat-shaded geometry layered over the body. This is the armored enemy variant with high health and damage. Mane is partially hidden by armor. Tail is short and thick.

## Technical Constraints
- **Triangle budget**: 4000 tris (hard cap)
- **Texture size**: 512x512 max
- **Material slots**: 3 (body, armor, accent)
- **UV mapping**: Auto-unwrap (Smart UV Project)
- **Rigging**: None (static mesh)
- **Animation**: None
- **Scale reference**: 1.7m tall at head, 2.3m long in Godot/Blender units

## Color Palette
- Primary: #CC2222 (dark red armor plates)
- Secondary: #4A4A4A (gray horse body under armor)
- Accent: #8B0000 (dark red trim on armor edges)

## Blender-MCP Tool Sequence
1. project_initialize — new file, metric units, clean scene
2. mesh_edit_batch — create wider body from cube, extrude 4 thick legs, extrude shorter neck, extrude blocky head; make proportions bulkier than standard horse
3. mesh_edit_batch — add loop cuts at joints, shape hooves; add armor plates as separate extruded faces on chest, flanks, and head (chamfron); add angular plate geometry on shoulders
4. mesh_edit_batch — refine armor edges with bevels, add short thick tail, partially visible mane between armor plates
5. material_pbr_build — slot 1: gray body (#4A4A4A, roughness 0.7, metallic 0.0); slot 2: red armor (#CC2222, roughness 0.4, metallic 0.5); slot 3: dark red trim (#8B0000, roughness 0.3, metallic 0.6)
6. uv_workflow — smart UV project, pack islands
7. render_preview — front + side orthographic, transparent background
8. quality_validate — check tri count ≤ 4000, manifold, no inverted normals, scale ~1.7m tall
9. export_asset — .glb to assets/models/horse-war.glb, apply modifiers

## Acceptance Criteria
- [ ] Triangle count ≤ 4000
- [ ] No inverted normals
- [ ] Manifold mesh (watertight)
- [ ] UV islands non-overlapping
- [ ] Height approximately 1.7m at head
- [ ] Armor plates clearly visible from top-down view
- [ ] Visually distinct from standard horses (bulkier, armored)
- [ ] Red/gray color scheme distinct from brown and black variants
- [ ] Preview renders reviewed
- [ ] Materials match color palette
- [ ] Imports cleanly into Godot (no Output panel errors)
- [ ] PROVENANCE.md entry created
