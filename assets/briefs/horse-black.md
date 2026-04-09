# Asset Brief: Black Horse

## Identity
- **Name**: horse-black
- **Category**: character
- **Art Style**: low-poly stylized
- **Target Engine**: Godot 4.6
- **Export Format**: .glb (GLTF Binary)

## Visual Description
A sleek black horse standing on four legs in a forward-leaning stance suggesting speed. Low-poly with visible facets. Slightly slimmer proportions than the brown horse — longer legs, narrower body. This is the fast enemy variant that moves quickly but has less health. Mane and tail are swept-back flat extrusions to emphasize speed. Subtle red glow on eyes for menace.

## Technical Constraints
- **Triangle budget**: 2000 tris (hard cap)
- **Texture size**: 512x512 max
- **Material slots**: 2 (body, eyes/accent)
- **UV mapping**: Auto-unwrap (Smart UV Project)
- **Rigging**: None (static mesh)
- **Animation**: None
- **Scale reference**: 1.5m tall at head, 2.1m long nose-to-tail in Godot/Blender units

## Color Palette
- Primary: #1A1A1A (near-black body)
- Secondary: #FF2222 (red eye glow accent)

## Blender-MCP Tool Sequence
1. project_initialize — new file, metric units, clean scene
2. mesh_edit_batch — create body from cube scaled to slightly narrower barrel shape than brown horse, extrude 4 longer legs, extrude neck forward and upward, extrude tapered head
3. mesh_edit_batch — add loop cuts at joints, shape hooves, extrude swept-back mane along neck, extrude swept-back tail from rear, add small eye indentations on head sides
4. material_pbr_build — slot 1: black body (#1A1A1A, roughness 0.5, metallic 0.1); slot 2: red eyes (#FF2222, roughness 0.2, metallic 0.0, emission 0.5)
5. uv_workflow — smart UV project, pack islands
6. render_preview — front + side orthographic, transparent background
7. quality_validate — check tri count ≤ 2000, manifold, no inverted normals, scale ~1.5m tall
8. export_asset — .glb to assets/models/horse-black.glb, apply modifiers

## Acceptance Criteria
- [ ] Triangle count ≤ 2000
- [ ] No inverted normals
- [ ] Manifold mesh (watertight)
- [ ] UV islands non-overlapping
- [ ] Height approximately 1.5m at head
- [ ] Visually distinct from brown horse (darker, sleeker silhouette)
- [ ] Red eye accent visible
- [ ] Preview renders reviewed
- [ ] Materials match color palette
- [ ] Imports cleanly into Godot (no Output panel errors)
- [ ] PROVENANCE.md entry created
