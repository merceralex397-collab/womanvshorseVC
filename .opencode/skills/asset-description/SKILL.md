---
name: asset-description
description: How to write actionable asset briefs for Blender-MCP 3D model generation. Use when creating or reviewing asset briefs in assets/briefs/ that drive the model generation pipeline.
---

# Asset Description Skill

Before writing any brief, call `skill_ping` with `skill_id: "asset-description"` and `scope: "project"`.

## Purpose

Asset briefs are the single source of truth for 3D model generation via Blender-MCP. Each brief must be precise enough that a subagent can execute the full tool sequence without human clarification.

## Brief Location

One file per asset in `assets/briefs/<asset-name>.md`

## Required Format

```markdown
# Asset Brief: <Display Name>

## Identity
- **Name**: <kebab-case-name>
- **Category**: character | prop | environment | pickup
- **Art Style**: low-poly stylized
- **Target Engine**: Godot 4.6
- **Export Format**: .glb (GLTF Binary)

## Visual Description
<2-4 sentences describing exactly what this looks like. Be specific about
proportions, colors, distinctive features. Use measurable terms. Avoid
subjective language like "cool" or "nice".>

## Technical Constraints
- **Triangle budget**: <N> tris (hard cap)
- **Texture size**: 512x512 max
- **Material slots**: <N> (<slot names>)
- **UV mapping**: Auto-unwrap (Smart UV Project)
- **Rigging**: None (static mesh)
- **Animation**: None
- **Scale reference**: <height in meters> tall in Godot/Blender units

## Color Palette
- Primary: #<hex> (<description>)
- Secondary: #<hex> (<description>)
- Accent: #<hex> (<description>, if needed)

## Blender-MCP Tool Sequence
1. project_initialize — new file, metric units
2. mesh_edit_batch — <specific modeling steps>
3. mesh_edit_batch — <refinement steps>
4. material_pbr_build — <material spec from palette>
5. uv_workflow — smart UV project, pack islands
6. render_preview — front + side orthographic
7. quality_validate — check tri count, manifold, scale
8. export_asset — .glb to assets/models/<name>.glb

## Acceptance Criteria
- [ ] Triangle count within budget
- [ ] No inverted normals
- [ ] Manifold mesh (watertight)
- [ ] UV islands non-overlapping
- [ ] Correct scale (matches reference)
- [ ] Preview renders reviewed
- [ ] Materials match color palette
- [ ] Imports cleanly into Godot (no Output panel errors)
- [ ] PROVENANCE.md entry created
```

## Writing Rules

### Be Specific
- BAD: "A horse"
- GOOD: "A brown horse standing on four legs, low-poly with visible facets, 2 meters tall at the head, blocky proportions with simplified mane and tail"

### Be Measurable
- Triangle counts are hard caps, not suggestions
- Material slot count determines Blender setup complexity
- Scale reference must match the game's unit system (1 unit = 1 meter)

### Be Actionable
- The Blender-MCP Tool Sequence must be executable as-is
- Each step should map to a specific tool call with inferrable parameters
- Include enough modeling detail that the agent knows WHAT to build, not just what tool to call

### Match the Style
- All models in this project are low-poly stylized
- Low-poly characters do not need 4K textures or complex UV islands
- Flat shading or subtle smooth shading only
- Bold color blocks, not realistic textures
- Clean silhouettes that read well from a top-down orthographic camera

### Consider Gameplay Readability
- Models are viewed from a fixed top-down orthographic camera
- Distinctive silhouettes matter more than front-facing detail
- Color contrast between player (green/silver) and enemies (brown/black/red) is critical
- Boss variants should be visibly larger and more distinctive

## Triangle Budget Guidelines

| Category | Budget Range | Notes |
|---|---|---|
| Player character | 2000-3000 tris | Most detail budget |
| Standard enemy | 1500-2000 tris | Many on screen at once |
| Elite/armored enemy | 3000-4000 tris | Fewer on screen |
| Boss enemy | 4000-5000 tris | One at a time |
| Environment (arena) | 300-500 tris | Simple ground + fence |
| Props/pickups | 50-200 tris | Very simple shapes |

## Validation Before Submission

Before committing a brief:
- Triangle budget is reasonable for the category (see table above)
- Color palette has hex values, not just color names
- Visual description is specific enough to model without questions
- Tool sequence covers all 7 pipeline stages
- Scale reference uses meters and matches game scale
- Acceptance criteria include all standard checks

## Output

Each completed brief is saved to `assets/briefs/<asset-name>.md` and referenced by the corresponding MODEL ticket for Blender-MCP execution.
