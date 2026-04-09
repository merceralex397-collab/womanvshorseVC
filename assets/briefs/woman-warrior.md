# Asset Brief: Woman Warrior

## Identity
- **Name**: woman-warrior
- **Category**: character
- **Art Style**: low-poly stylized
- **Target Engine**: Godot 4.6
- **Export Format**: .glb (GLTF Binary)

## Visual Description
A warrior woman in a standing combat pose holding a sword in her right hand. Low-poly with visible facets and blocky proportions. She wears simple plate armor on torso and shoulders with a short skirt/tunic below. Hair is a simplified solid wedge shape swept back. The sword is a straight longsword integrated into the mesh. Proportions are slightly stylized — head slightly larger than realistic for top-down readability.

## Technical Constraints
- **Triangle budget**: 3000 tris (hard cap)
- **Texture size**: 512x512 max
- **Material slots**: 3 (skin, armor, sword)
- **UV mapping**: Auto-unwrap (Smart UV Project)
- **Rigging**: None (static mesh)
- **Animation**: None
- **Scale reference**: 1.7m tall in Godot/Blender units

## Color Palette
- Primary: #2E7D32 (dark green armor)
- Secondary: #C0C0C0 (silver sword and shoulder plates)
- Accent: #FFCCBC (skin tone for face and arms)

## Blender-MCP Tool Sequence
1. project_initialize — new file, metric units, clean scene
2. mesh_edit_batch — create torso from cube, extrude legs, arms, neck, head from cube primitives; extrude sword shape from right hand area
3. mesh_edit_batch — add loop cuts at joints (elbows, knees, waist), shape head into simplified face wedge, add shoulder plate geometry, shape hair as extruded wedge from back of head
4. material_pbr_build — slot 1: green armor (#2E7D32, roughness 0.6, metallic 0.3); slot 2: silver metal (#C0C0C0, roughness 0.3, metallic 0.8); slot 3: skin (#FFCCBC, roughness 0.8, metallic 0.0)
5. uv_workflow — smart UV project, pack islands
6. render_preview — front + side orthographic, transparent background
7. quality_validate — check tri count ≤ 3000, manifold, no inverted normals, scale 1.7m
8. export_asset — .glb to assets/models/woman-warrior.glb, apply modifiers

## Acceptance Criteria
- [ ] Triangle count ≤ 3000
- [ ] No inverted normals
- [ ] Manifold mesh (watertight)
- [ ] UV islands non-overlapping
- [ ] Height approximately 1.7m
- [ ] Green armor clearly visible from top-down view
- [ ] Sword silhouette readable from above
- [ ] Preview renders reviewed
- [ ] Materials match color palette
- [ ] Imports cleanly into Godot (no Output panel errors)
- [ ] PROVENANCE.md entry created
