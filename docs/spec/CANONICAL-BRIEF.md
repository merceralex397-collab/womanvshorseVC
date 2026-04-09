# Canonical Brief

## Project Summary

Replace this section with the normalized project brief.

## Goals

- Replace with explicit outcomes

## Non-Goals

- Replace with explicit exclusions

## Constraints

- Runtime: Ubuntu
- Workflow: local-git-capable, ticketed, deterministic
- Agent design: autonomous with internal gates, no `ask`
- OpenCode layer: commands for humans, tools/plugins for autonomy

## Tooling and Model Constraints

- Provider: `minimax-coding-plan`
- Planner/reviewer model: `minimax-coding-plan/minimax-coding-plan/MiniMax-M2.7`
- Implementer model: `minimax-coding-plan/minimax-coding-plan/MiniMax-M2.7`
- Utility/helper model: `minimax-coding-plan/minimax-coding-plan/MiniMax-M2.7`

## Required Outputs

- repo structure
- docs
- ticket pack
- OpenCode agents, tools, plugins, commands, and local skills

## Canonical Truth Map

- Facts and decisions: `docs/spec/CANONICAL-BRIEF.md`
- Queue state and artifact metadata: `tickets/manifest.json`
- Transient stage state: `.opencode/state/workflow-state.json`
- Artifact bodies: the stage-specific directories under `.opencode/state/`
- Artifact registry: `.opencode/state/artifacts/registry.json`
- Restart surface: `START-HERE.md`

## Blocking Decisions

- Replace with the recorded batched decision packet for this repo
- Resolve every blocking item here before generation continues

## Non-Blocking Open Questions

- Replace with unresolved items

## Backlog Readiness

- Replace with whether the first execution wave can be generated immediately after the blocking decision packet is resolved

## Acceptance Signals

- Replace with project-specific success criteria

## Assumptions

- Replace with any required assumptions

## Product Finish Contract

- deliverable_kind: Android game APK — woman fights waves of enemy horses in 3D
- placeholder_policy: No placeholder models. 3D assets generated via Blender-MCP server. GLB exports.
- visual_finish_target: Low-poly 3D top-down view. Models generated via blender-agent MCP. Stylized art direction.
- audio_finish_target: Minimal SFX. Generated or sourced from open repositories.
- content_source_plan: 3D models via blender-agent MCP (GLB export). Audio from open sources. Asset briefs drive generation.
- licensing_or_provenance_constraints: AI-generated 3D models (CC0). Open-source audio. Full provenance tracking.
- finish_acceptance_signals: APK compiles and installs. All waves playable. 3D models load correctly. Touch controls work.
