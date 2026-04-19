# Agent Delegation

This document is the human-readable delegation map for the generated OpenCode team.
`opencode-team-bootstrap` must refresh it so it matches the actual agent files in `.opencode/agents/` for this repo.

## Team Composition

- visible coordinator: `wvhvc-team-leader`
- planning lane: `wvhvc-planner` and `wvhvc-plan-review`
- implementation lane: `wvhvc-lane-executor`, `wvhvc-implementer`, and `wvhvc-blender-asset-creator` for Blender-routed asset tickets
- review lane: `wvhvc-reviewer-code` and `wvhvc-reviewer-security`
- QA lane: `wvhvc-tester-qa`
- closeout lane: `wvhvc-docs-handoff`
- trust-restoration lane: `wvhvc-backlog-verifier` and `wvhvc-ticket-creator`

## Delegation Chain

1. `wvhvc-team-leader` resolves canonical state with `ticket_lookup`
2. `wvhvc-planner` writes the planning artifact
3. `wvhvc-plan-review` approves or rejects the plan
4. `wvhvc-lane-executor` or `wvhvc-implementer` performs the approved implementation lane unless the ticket's primary deliverable is a Blender-generated asset, in which case `wvhvc-blender-asset-creator` owns implementation
5. `wvhvc-reviewer-code` and `wvhvc-reviewer-security` return findings or approval evidence
6. `wvhvc-tester-qa` runs QA and returns the QA artifact
7. `wvhvc-team-leader` runs `smoke_test`, advances lifecycle state, and routes closeout
8. `wvhvc-docs-handoff` synchronizes restart surfaces when closeout is ready

## Ownership Rules

- only the team leader advances ticket lifecycle state
- only the owning specialist or tool writes the stage artifact body
- read-only specialists return findings, blockers, or evidence; they do not mutate repo-tracked files
- write-capable specialists work only inside a claimed lease and only for the bounded lane they were assigned
- Blender-routed asset tickets must delegate to `wvhvc-blender-asset-creator`, not to the generic implementer or lane executor

## Escalation Path

Stop and escalate to the operator when:

- canonical workflow tools disagree and the contradiction rules in the team-leader prompt do not resolve the conflict
- `environment_bootstrap` still reports unresolved blockers after safe recovery commands were attempted
- the same ticket advance fails three times with the same blocker or error signature
- a dependency ticket is blocked and prevents the active ticket from moving
- no single legal next move can be resolved from `ticket_lookup.transition_guidance` and the canonical artifacts

## Restart Procedure

1. read `START-HERE.md`
2. read `docs/spec/CANONICAL-BRIEF.md` and `docs/process/workflow.md` when the current state is unclear
3. run `ticket_lookup` for the active ticket
4. trust `tickets/manifest.json` and `.opencode/state/workflow-state.json` over derived restart surfaces
5. resume from the next required stage instead of improvising a new delegation path
