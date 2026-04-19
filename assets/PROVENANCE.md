# Asset Provenance

Track every sourced or generated asset added to this repo in the same ticket that introduces it.

## Rules

- Every entry must use a repo-relative path under `assets/` or a Godot `res://` import path.
- Generated assets must record the exact workflow or tool used to create them.
- Third-party assets must keep the source URL and precise license value.
- Record tool-stack license policy separately from model/checkpoint license policy when AI-assisted generation is used.
- Procedural or intentionally no-external-asset repos must still record the active route and any generated runtime content surfaces.

| asset_path | source_or_workflow | license | author | acquired_or_generated_on | notes |
| --- | --- | --- | --- | --- | --- |

## Existing Provenance Notes

All assets in this project must have a tracked provenance entry below.

| asset_path | source_url | license | author | date_acquired |
|---|---|---|---|---|
| assets/models/woman-warrior.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-10 |
| assets/models/horse-brown.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-10 |
| assets/models/horse-black.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-17 |
| assets/models/horse-boss.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-17 |
| assets/models/horse-war.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-17 |
| assets/models/arena-ground.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-17 |
| assets/models/heart-pickup.glb | blender-mcp-generated | CC0 (AI-generated) | blender-agent MCP | 2026-04-18 |
