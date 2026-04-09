# START HERE

<!-- SCAFFORGE:START_HERE_BLOCK START -->
## What This Repo Is

Woman vs Horse VC — A 3D low-poly arena action game for Android. Warrior woman fights waves of enemy horses. Built with Godot 4.6 (Forward+ renderer). 3D models generated via blender-agent MCP server.

## Current State

Scaffold complete. Skills, asset briefs, agents, and tickets are populated and ready for execution. Model generation (Wave 1) can begin immediately — all MODEL tickets are parallel-safe with no dependencies.

## Read In This Order

1. README.md
2. AGENTS.md
3. docs/spec/CANONICAL-BRIEF.md
4. docs/process/workflow.md
5. tickets/manifest.json
6. tickets/BOARD.md

## Key Skills

| Skill | Purpose |
|---|---|
| `godot-3d-android-game` | Godot 4.6 3D patterns, GLB import, orthographic camera |
| `blender-mcp-workflow` | Blender-MCP tool sequence for 3D model generation |
| `asset-description` | How to write actionable asset briefs |
| `model-operating-profile` | MiniMax-M2.7 prompting constraints |
| `stack-standards` | Godot 4.6 + GDScript coding standards |

## Asset Pipeline

1. Asset briefs in `assets/briefs/` define each model
2. Blender-MCP tools generate `.glb` files → `assets/models/`
3. Godot auto-imports GLB on project load
4. Provenance tracked in `assets/PROVENANCE.md`

## Wave Execution Order

- **Wave 1 (model-generation)**: MODEL-001 through MODEL-006 — all parallel-safe, no deps
- **Wave 0 (scene-setup)**: SETUP-001 (needs MODEL-006), SETUP-002 (needs SETUP-001)
- **Wave 2 (core + ui)**: CORE-001–006, UI-001–002 — see BOARD.md for deps
- **Wave 3 (release)**: RELEASE-001 — depends on all above

## Current Or Next Ticket

- ID: MODEL-001
- Title: Generate woman-warrior via Blender-MCP
- Wave: 1
- Lane: model-generation
- Stage: planning
- Status: todo
- Resolution: open
- Verification: suspect

## Dependency Status

- current_ticket_done: no
- dependent_tickets_waiting_on_current: CORE-006
- split_child_tickets: none

## Generation Status

- handoff_status: scaffold-kickoff complete
- process_version: 7
- parallel_mode: sequential (MODEL tickets are parallel-safe exceptions)
- pending_process_verification: false
- repair_follow_on_outcome: clean
- repair_follow_on_required: false
- repair_follow_on_next_stage: none
- repair_follow_on_verification_passed: true
- repair_follow_on_updated_at: Not yet recorded.
- bootstrap_status: pending
- bootstrap_proof: None
- process_changed_at: Not yet recorded.

## Post-Generation Audit Status

- audit_or_repair_follow_up: none recorded
- reopened_tickets: none
- done_but_not_fully_trusted: none
- pending_reverification: none
- repair_follow_on_blockers: none

## Known Risks

- Blender-MCP server must be running before MODEL ticket execution.
- GLB import depends on Godot editor or headless mode being available.
- Android SDK/NDK must be configured for RELEASE-001.

## Next Action

Begin Wave 1: Execute MODEL-001 through MODEL-006 via blender-agent MCP. Read `blender-mcp-workflow` skill and the corresponding asset brief before each model ticket.
<!-- SCAFFORGE:START_HERE_BLOCK END -->
