# BLOCKER — MODEL-007: Blender-MCP tools not accessible to wvhvc-implementer

## Ticket
- **ID**: MODEL-007
- **Title**: Generate sword-projectile via Blender-MCP
- **Stage**: implementation
- **Lane**: model-generation

## Blocker Classification
**BLOCKER — wrong worker for Blender-routed ticket**

## Evidence

### Required tools (per blender-mcp-workflow skill)
The skill specifies this tool sequence:
1. `blender_agent_project_initialize` — NOT in available tools
2. `blender_agent_scene_batch_edit` — NOT in available tools
3. `blender_agent_mesh_edit_batch` — NOT in available tools
4. `blender_agent_material_pbr_build` — NOT in available tools
5. `blender_agent_render_preview` — NOT in available tools
6. `blender_agent_quality_validate` — NOT in available tools
7. `blender_agent_export_asset` — NOT in available tools

### Available Blender tools to wvhvc-implementer
```
blender_agent_addon_configure
blender_agent_simulation_cache
blender_agent_asset_publish
blender_agent_import_asset
blender_agent_data_access
blender_agent_blender_live_status
blender_agent_blender_live_operator
blender_agent_blender_live_data
blender_agent_blender_live_capture
blender_agent_blender_viewport_capture
blender_agent_blender_watch_events
blender_agent_blender_session_snapshot
blender_agent_blender_action_trace
blender_agent_blender_watch_intervention
```

These are all "live runtime" and control-plane tools. The certified legacy v1 API tools needed for model generation (`project_initialize`, `scene_batch_edit`, etc.) are NOT exposed to this worker.

## Root Cause
Per AGENTS.md: *"never call `blender_agent_*` tools yourself for a Blender-routed ticket; those tools belong to `wvhvc-blender-asset-creator`"*. The `wvhvc-blender-asset-creator` is a separate specialist agent that owns Blender-routed work. This implementer session does not have `blender_agent_*` tool access.

## Required Resolution
Route MODEL-007 to `wvhvc-blender-asset-creator` for implementation, or grant this worker the certified Blender MCP legacy v1 tool access (`project_initialize`, `scene_batch_edit`, `mesh_edit_batch`, `material_pbr_build`, `render_preview`, `quality_validate`, `export_asset`).

## Preconditions for retry
This implementer can proceed ONLY if one of these is true:
1. MODEL-007 is reassigned to `wvhvc-blender-asset-creator` and this worker yields the lane
2. The Blender MCP tool access is granted to this worker for the duration of MODEL-007
3. A Blender MCP bridge wrapper is created that this implementer can call safely

## Dependency Impact
- VISUAL-001 (parent) has follow-ups: MODEL-007, MODEL-008, FENCE-001
- MODEL-007 is sequential_dependent from VISUAL-001
- MODEL-008 and FENCE-001 are parallel_independent from each other but sequential from VISUAL-001

## Audit Log Reference
No Blender-MCP calls were attempted — tools not available to call.
