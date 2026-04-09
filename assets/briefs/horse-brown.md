# Asset Brief: Brown Horse

## Identity
- **Name**: horse-brown
- **Category**: character
- **Art Style**: low-poly stylized
- **Target Engine**: Godot 4.6
- **Export Format**: .glb (GLTF Binary)

## Visual Description
A basic brown horse standing on four legs in a neutral stance. Low-poly with visible facets. Blocky proportions — barrel-shaped body, thick cylindrical legs, simplified wedge-shaped head. Mane and tail are flat extruded shapes, not individual strands. This is the most common enemy type, appearing in large groups.

## Technical Constraints
- **Triangle budget**: 2000 tris (hard cap)
- **Texture size**: 512x512 max
- **Material slots**: 2 (body, mane/tail)
- **UV mapping**: Auto-unwrap (Smart UV Project)
- **Rigging**: None (static mesh)
- **Animation**: None
- **Scale reference**: 1.5m tall at head, 2.0m long nose-to-tail in Godot/Blender units

## Color Palette
- Primary: #8B4513 (saddle brown body)
- Secondary: #2F1B0E (dark brown mane and tail)

## Blender-MCP Tool Sequence
1. project_initialize — new file, metric units, clean scene
2. mesh_edit_batch — create body from cube scaled to barrel shape, extrude 4 legs downward, extrude neck forward and upward, extrude head as tapered box from neck
3. mesh_edit_batch — add loop cuts at leg joints and neck, shape hooves as flattened cylinders, extrude mane as flat strip along neck top, extrude tail as tapered flat strip from rear
4. material_pbr_build — slot 1: brown body (#8B4513, roughness 0.7, metallic 0.0); slot 2: dark mane/tail (#2F1B0E, roughness 0.8, metallic 0.0)
5. uv_workflow — smart UV project, pack islands
6. render_preview — front + side orthographic, transparent background
7. quality_validate — check tri count ≤ 2000, manifold, no inverted normals, scale ~1.5m tall
8. export_asset — .glb to assets/models/horse-brown.glb, apply modifiers

## Acceptance Criteria
- [ ] Triangle count ≤ 2000
- [ ] No inverted normals
- [ ] Manifold mesh (watertight)
- [ ] UV islands non-overlapping
- [ ] Height approximately 1.5m at head
- [ ] Clearly reads as a horse from top-down view
- [ ] Brown body distinct from dark mane
- [ ] Preview renders reviewed
- [ ] Materials match color palette
- [ ] Imports cleanly into Godot (no Output panel errors)
- [ ] PROVENANCE.md entry created
