# Asset Brief: Arena Ground

## Identity
- **Name**: arena-ground
- **Category**: environment
- **Art Style**: low-poly stylized
- **Target Engine**: Godot 4.6
- **Export Format**: .glb (GLTF Binary)

## Visual Description
A flat rectangular grass arena with a simple wooden fence border. The ground is a single flat plane with a green grass color. The fence is a series of low rectangular posts connected by horizontal rails running along all four edges. The arena is where all gameplay takes place — viewed from a fixed top-down orthographic camera. The fence serves as the visual boundary. Simple and clean with no interior obstacles.

## Technical Constraints
- **Triangle budget**: 500 tris (hard cap)
- **Texture size**: 512x512 max
- **Material slots**: 2 (grass ground, wood fence)
- **UV mapping**: Auto-unwrap (Smart UV Project)
- **Rigging**: None (static mesh)
- **Animation**: None
- **Scale reference**: 20m × 20m ground plane, fence posts 1m tall in Godot/Blender units

## Color Palette
- Primary: #4CAF50 (medium green grass)
- Secondary: #795548 (brown wood fence)

## Blender-MCP Tool Sequence
1. project_initialize — new file, metric units, clean scene
2. mesh_edit_batch — create ground plane 20m × 20m; create fence posts as cubes (0.15m × 0.15m × 1.0m) at corners and every 2.5m along edges; create horizontal rails as thin cubes connecting posts at 0.3m and 0.7m height
3. mesh_edit_batch — minor cleanup: ensure fence posts sit on ground plane, rails connect cleanly to posts
4. material_pbr_build — slot 1: grass (#4CAF50, roughness 0.9, metallic 0.0); slot 2: wood (#795548, roughness 0.8, metallic 0.0)
5. uv_workflow — smart UV project, pack islands
6. render_preview — top-down orthographic (matches game camera), transparent background
7. quality_validate — check tri count ≤ 500, manifold, no inverted normals, scale 20m × 20m
8. export_asset — .glb to assets/models/arena-ground.glb, apply modifiers

## Acceptance Criteria
- [ ] Triangle count ≤ 500
- [ ] No inverted normals
- [ ] Manifold mesh (watertight)
- [ ] UV islands non-overlapping
- [ ] Ground plane is 20m × 20m
- [ ] Fence posts approximately 1m tall
- [ ] Clearly reads as a fenced arena from top-down view
- [ ] Green/brown color contrast clear
- [ ] Preview renders reviewed
- [ ] Materials match color palette
- [ ] Imports cleanly into Godot (no Output panel errors)
- [ ] PROVENANCE.md entry created
