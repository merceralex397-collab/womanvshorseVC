# Asset Brief: Boss Horse

## Identity
- **Name**: horse-boss
- **Category**: character
- **Art Style**: low-poly stylized
- **Target Engine**: Godot 4.6
- **Export Format**: .glb (GLTF Binary)

## Visual Description
A large imposing boss horse standing on four legs in a rearing-ready stance. Low-poly with visible facets. Significantly larger than standard horses — 1.3x scale in all dimensions. Wears ornate gold armor covering the chest, head, and back. A crown-like crest on the head armor. Thick armored legs with gold greaves. Flowing gold-trimmed mane visible between armor segments. This is the wave boss — appears alone or with minimal escort, has high health and powerful attacks.

## Technical Constraints
- **Triangle budget**: 5000 tris (hard cap)
- **Texture size**: 512x512 max
- **Material slots**: 3 (body, gold armor, dark accent)
- **UV mapping**: Auto-unwrap (Smart UV Project)
- **Rigging**: None (static mesh)
- **Animation**: None
- **Scale reference**: 2.2m tall at head, 2.8m long in Godot/Blender units

## Color Palette
- Primary: #FFD700 (gold armor and crown crest)
- Secondary: #2C2C2C (dark charcoal body under armor)
- Accent: #B8860B (dark goldenrod for armor trim and details)

## Blender-MCP Tool Sequence
1. project_initialize — new file, metric units, clean scene
2. mesh_edit_batch — create large body from cube (1.3x wider/taller than standard horse), extrude 4 thick armored legs, extrude powerful neck, extrude large blocky head
3. mesh_edit_batch — add loop cuts at all joints; build ornate chest armor plate (peytral) with layered angular geometry; add head armor (chamfron) with crown crest as upward extrusions
4. mesh_edit_batch — add back armor plates, leg greaves as cylindrical overlays, flowing mane segments between armor plates, thick tail with armor base
5. material_pbr_build — slot 1: dark body (#2C2C2C, roughness 0.6, metallic 0.0); slot 2: gold armor (#FFD700, roughness 0.3, metallic 0.8); slot 3: dark gold trim (#B8860B, roughness 0.4, metallic 0.7)
6. uv_workflow — smart UV project, pack islands
7. render_preview — front + side + 3-quarter orthographic, transparent background
8. quality_validate — check tri count ≤ 5000, manifold, no inverted normals, scale ~2.2m tall
9. export_asset — .glb to assets/models/horse-boss.glb, apply modifiers

## Acceptance Criteria
- [ ] Triangle count ≤ 5000
- [ ] No inverted normals
- [ ] Manifold mesh (watertight)
- [ ] UV islands non-overlapping
- [ ] Height approximately 2.2m at head (visibly larger than other horses)
- [ ] Gold armor clearly visible and dominant from top-down view
- [ ] Crown crest on head readable from above
- [ ] Visually distinct as a boss (larger, more ornate, gold)
- [ ] Preview renders reviewed
- [ ] Materials match color palette
- [ ] Imports cleanly into Godot (no Output panel errors)
- [ ] PROVENANCE.md entry created
