# Agent Catalog

Prefix: `wvhvc`

Visible entrypoint:

- `wvhvc-team-leader`

Core hidden specialists:

- `wvhvc-planner`
- `wvhvc-plan-review`
- `wvhvc-implementer`
- `wvhvc-reviewer-code`
- `wvhvc-reviewer-security`
- `wvhvc-tester-qa`
- `wvhvc-docs-handoff`
- `wvhvc-backlog-verifier`
- `wvhvc-ticket-creator`

Utility hidden specialists:

- `wvhvc-utility-explore`
- `wvhvc-utility-shell-inspect`
- `wvhvc-utility-summarize`
- `wvhvc-utility-ticket-audit`
- `wvhvc-utility-github-research`
- `wvhvc-utility-web-research`

Workflow contract:

- the team leader advances stages through ticket tools and workflow state, not by manually editing ticket files
- each major stage must leave a canonical artifact before the next stage begins
- read-only specialists return findings, artifacts, or blockers instead of mutating repo files
- per-ticket stage order stays sequential, and the repo defaults to one active lane unless bounded parallel work is explicitly justified
- the backlog verifier reads canonical artifact bodies through `ticket_lookup` before deciding whether old completion still holds
- the team leader runs the deterministic `smoke_test` tool between QA and closeout instead of delegating that stage to another agent
- post-migration, remediation, or reverification follow-up tickets are created only from current registered evidence through the guarded ticket flow
- when the asset pipeline requires Blender-MCP, `wvhvc-blender-asset-creator` owns repo-scoped 3D asset generation via the managed `blender_agent` MCP, the local `asset-description` / `blender-mcp-workflow` skills, and audit-backed saved-blend chaining
