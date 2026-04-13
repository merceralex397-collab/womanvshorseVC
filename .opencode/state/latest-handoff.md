# START HERE

<!-- SCAFFORGE:START_HERE_BLOCK START -->
## What This Repo Is

Woman vs Horse VC

## Current State

The repo is operating under the managed OpenCode workflow. Use the canonical state files below instead of memory or raw ticket prose.

## Read In This Order

1. README.md
2. AGENTS.md
3. docs/AGENT-DELEGATION.md
4. docs/spec/CANONICAL-BRIEF.md
5. docs/process/workflow.md
6. tickets/manifest.json
7. tickets/BOARD.md

## Current Or Next Ticket

- ID: REMED-003
- Title: Remediation review artifact does not contain runnable command evidence
- Wave: 6
- Lane: remediation
- Stage: review
- Status: review
- Resolution: open
- Verification: suspect

## Dependency Status

- current_ticket_done: no
- dependent_tickets_waiting_on_current: none
- split_child_tickets: REMED-004, REMED-006, REMED-007, REMED-008

## Generation Status

- handoff_status: workflow verification pending
- process_version: 7
- parallel_mode: sequential
- pending_process_verification: true
- repair_follow_on_outcome: source_follow_up
- repair_follow_on_required: false
- repair_follow_on_next_stage: none
- repair_follow_on_verification_passed: true
- repair_follow_on_updated_at: 2026-04-12T03:09:17Z
- pivot_in_progress: false
- pivot_class: none
- pivot_changed_surfaces: none
- pivot_pending_stages: none
- pivot_completed_stages: none
- pivot_pending_ticket_lineage_actions: none
- pivot_completed_ticket_lineage_actions: none
- post_pivot_verification_passed: false
- bootstrap_status: ready
- bootstrap_proof: .opencode/state/artifacts/history/model-001/bootstrap/2026-04-09T22-20-16-559Z-environment-bootstrap.md
- bootstrap_blockers: none

## Post-Generation Audit Status

- audit_or_repair_follow_up: follow-up required
- reopened_tickets: none
- done_but_not_fully_trusted: none
- pending_reverification: none
- repair_follow_on_blockers: none
- pivot_pending_stages: none
- pivot_pending_ticket_lineage_actions: none

## Code Quality Status

- last_build_result: unknown @ 2026-04-11T19:02:03.732Z
- last_test_run_result: fail @ 2026-04-10T22:04:57.743Z
- open_remediation_tickets: 6
- known_reference_integrity_issues: 0

## Known Risks

- Managed repair converged, but source-layer follow-up still remains in the ticket graph.
- Historical completion should not be treated as fully trusted until pending process verification or explicit reverification is cleared.
- The workflow still records pending process verification even though no done tickets remain affected; clear the workflow flag before relying on a clean-state restart narrative.
- REMED-003 is an open split parent; child tickets REMED-004, REMED-006, REMED-007, REMED-008 remain the active foreground work.

## Next Action

Keep REMED-003 open as a split parent and continue the child ticket lanes: REMED-004, REMED-006, REMED-007, REMED-008.
<!-- SCAFFORGE:START_HERE_BLOCK END -->
