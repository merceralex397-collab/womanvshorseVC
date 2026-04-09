---
name: model-operating-profile
description: Apply the MiniMax-M2.7 Standard-tier evidence-first operating profile. Use when shaping prompts, delegation briefs, review asks, or evidence requests for this repo. Includes model-specific constraints and workarounds.
---

# Model Operating Profile

Before reading anything else, call `skill_ping` with `skill_id: "model-operating-profile"` and `scope: "project"`.

Selected runtime profile:

- model tier: `standard`
- provider: `minimax-coding-plan`
- team lead / planner / reviewers: `minimax-coding-plan/minimax-coding-plan/MiniMax-M2.7`
- implementer: `minimax-coding-plan/minimax-coding-plan/MiniMax-M2.7`
- utilities, docs, and QA helpers: `minimax-coding-plan/minimax-coding-plan/MiniMax-M2.7`
- operating profile: `Standard-tier evidence-first profile`
- prompt density: `explicit checklists with selective examples and linked truth sources`

## MiniMax-M2.7 Constraints

Known limitations of the MiniMax-M2.7 model that affect prompt design:

- **Context window**: ~128K tokens. Keep delegation briefs under 4K tokens. Reference docs by path instead of inlining.
- **Code generation accuracy**: Good for single-file changes. For multi-file changes, provide explicit file paths and exact code locations.
- **GDScript familiarity**: Moderate. Always include the exact class hierarchy (`extends CharacterBody3D`) and required method signatures. Do not assume it knows Godot 4.x API changes from 3.x.
- **Tool call reliability**: May skip validation steps if not explicitly required. Always include "run X command and include output" in checklists.
- **Long output degradation**: Quality drops in outputs over 2K tokens. Break large implementations into focused sub-tasks.
- **Blender/3D knowledge**: Limited. Always reference `blender-mcp-workflow` skill for exact tool sequences rather than expecting freeform 3D modeling instructions.

## Prompting Rules

Use this profile when drafting:

- task prompts
- delegation briefs
- review requests
- handoff expectations

Profile guidance:

`Keep prompts explicit and bounded, but use lighter repetition. Preserve stop conditions and verification checklists while relying more on linked canonical docs than inline examples.`

Required rules:

- keep stop conditions and verification checklists explicit
- reference canonical truth surfaces directly when they already contain the durable procedure
- use examples only where the workflow would otherwise stay ambiguous
- keep tasks bounded and evidence-first
- surface blockers clearly instead of improvising around them
- for Godot work, always specify the exact node type and parent path
- for Blender-MCP work, always reference the asset brief path and expected tool sequence
- include the exact validation command in every implementation checklist

When ambiguity is likely, prefer a concrete output shape such as:

```text
Goal
Constraints
Expected output
Evidence required
Blockers
```

## Delegation Brief Template (3D Game)

```text
Goal: [one sentence]
Ticket: [ID]
Asset brief: assets/briefs/[name].md (if model work)
Files to modify: [explicit list]
Constraints:
  - Triangle budget: [N] tris
  - Export format: GLB
  - Node type: [CharacterBody3D / StaticBody3D / etc.]
Expected output:
  - [list of files created/modified]
Evidence required:
  - [validation command and expected result]
Blockers:
  - [known issues or missing prerequisites]
```
