---
name: blender-mcp-workflow
description: Run the stateless blender-agent MCP pipeline for Woman vs Horse VC GLB assets. Use when a ticket creates or updates a required low-poly 3D model.
---

# Blender-MCP Workflow

Before using this workflow, call `skill_ping` with `skill_id: "blender-mcp-workflow"` and `scope: "project"`.

## Contract

The asset workflow is stateless across MCP calls. Every operation that depends on prior Blender work must pass the previous `persistence.saved_blend` value as `input_blend`, and every mutating operation must request or record an `output_blend` for the next step. Do not rely on a live editor session to preserve state between calls.

## Repo Paths

- MCP server source: `/home/pc/projects/blender-agent`
- Server command: `cd /home/pc/projects/blender-agent/mcp-server && python3 -m blender_mcp_server`
- Blender binary: `/home/pc/blender-4.5.0/blender`
- Asset briefs: `assets/briefs/<asset-name>.md`
- Blender working files: `assets/models/<asset-name>.blend`
- Godot imports: `assets/models/<asset-name>.glb`
- Preview renders: `.blender-mcp/renders/`
- Provenance ledger: `assets/PROVENANCE.md`

## Required Assets

- `woman-warrior`: warrior woman with sword, about 3000 triangles
- `horse-brown`: basic horse enemy, about 2000 triangles
- `horse-black`: fast horse variant, about 2000 triangles
- `horse-war`: armored horse, about 4000 triangles
- `horse-boss`: large boss horse, about 5000 triangles
- `arena-ground`: grass arena with fence border, about 500 triangles
- `sword-projectile`: thrown sword, about 200 triangles
- `heart-pickup`: health pickup, about 100 triangles

## Stateless Pipeline

For each asset brief:

1. Read `assets/briefs/<asset-name>.md` and confirm scale, triangle budget, silhouette, and color palette.
2. Create or load the starting `.blend` through the MCP project initialization tool. Record the returned `persistence.saved_blend`.
3. For mesh construction, call the mesh edit tool with `input_blend` set to the previous saved blend. Record the returned `output_blend` or `persistence.saved_blend`.
4. For material assignment, UV work, modifiers, or scene edits, always chain the last saved path forward as `input_blend`.
5. Generate front, top, and three-quarter preview renders into `.blender-mcp/renders/`.
6. Run quality validation against the brief's triangle budget, normal direction, manifold state, scale, and UV constraints.
7. Export GLB to `assets/models/<asset-name>.glb` from the latest saved blend.
8. Update `assets/PROVENANCE.md` with asset path, source, license, generation tool, and date.
9. Run Godot import validation with `godot --headless --path . --quit`.

## Tool Usage Rules

- Prefer primitive mesh construction and simple low-poly shaping over high subdivision.
- Keep material node trees simple; use Principled BSDF-compatible PBR materials.
- Do not export FBX, OBJ, or non-GLB formats for Godot.
- Do not add animation or armatures unless the asset brief explicitly requires them.
- Keep 1 Blender unit equal to 1 Godot meter.
- Preserve each `output_blend` path in the ticket artifact so the next agent can resume deterministically.
- If an MCP operation fails, retry from the last known `persistence.saved_blend` rather than assuming in-memory state survived.

## Brief To Parameter Mapping

| Brief Field | MCP Parameter |
|---|---|
| Triangle budget | `max_triangles` during quality validation |
| Primary color | material base color |
| Secondary color | additional material slot color |
| Scale reference | expected scale or dimensions |
| Export path | `assets/models/<asset-name>.glb` |
| Working file path | `input_blend` or `output_blend` |

## Validation Checklist

- Triangle count is within the asset brief budget.
- Normals face outward and no critical inverted-normal errors remain.
- Mesh is manifold enough for Godot import and gameplay collision usage.
- UVs are generated and do not create obvious texture artifacts.
- Preview renders match the brief silhouette and low-poly style.
- GLB exists at `assets/models/<asset-name>.glb`.
- Godot imports the GLB during `godot --headless --path . --quit`.
- `assets/PROVENANCE.md` records the generation source and license.

## Blockers

Return a blocker instead of fabricating proof when:

- the blender-agent MCP server is unavailable;
- `/home/pc/blender-4.5.0/blender` is missing;
- a tool call does not return a usable `persistence.saved_blend`, `input_blend`, or `output_blend` chain;
- Godot import validation cannot run on the host;
- the generated model cannot meet the brief's triangle or silhouette requirements without changing the brief.
