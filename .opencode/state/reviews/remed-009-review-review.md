# Review Artifact — REMED-009

**Ticket**: REMED-009  
**Stage**: review  
**Kind**: review  
**Owner**: wvhvc-plan-review  
**Lane**: remediation  
**Wave**: 15  

---

## 1. Review Request

Review the planning artifact for REMED-009 and produce a review verdict.

**Plan artifact**: `.opencode/state/artifacts/history/remed-009/planning/2026-04-17T02-19-23-295Z-plan.md`

**Ticket ACs:**
- AC-1: The validated finding `EXEC-BLENDER-001` no longer reproduces.
- AC-2: Before escalating a Blender-MCP defect, prove one correct chain: `project_initialize(output_blend=...)`, then a mutating follow-up that reuses the returned `persistence.saved_blend` as `input_blend`, and verify `.blender-mcp/audit/*.jsonl` records non-null `input_blend` / `output_blend` on the matching `job_start`.

**Finding source**: EXEC-BLENDER-001 — Blender MCP bridge forwarding null input_blend/output_blend in audit logs.

---

## 2. Plan Summary

- **Root cause identified**: Blender MCP bridge (1) always injects `--factory-startup` regardless of input_blend presence, and (2) does not write `input_blend` into job JSON even when `--factory-startup` is absent.
- **Audit evidence**: Table of 8 job records from `audit_20260411.jsonl` confirming `input_blend: null` on all records, including a `project_initialize` call with NO `--factory-startup`.
- **5-step approach**: probe bridge state → audit log baseline → attempt correct chain (expected to fail, confirming defect) → if bridge repaired during ticket, re-run → closeout evidence.
- **BRIDGE-DEFECT blocker**: Explicitly documented — bridge must be repaired before ticket can close. No repair mechanism exists within this ticket's scope.

---

## 3. AC Mapping Evaluation

| AC | Requirement | Plan Pass Criterion | Verdict |
|----|-------------|---------------------|---------|
| AC-1 | EXEC-BLENDER-001 no longer reproduces | Mutating call receives non-null `input_blend` in job JSON and audit log records it | **Mapped** — Step 3b is the test call |
| AC-2 | Audit log shows non-null input_blend/output_blend on correct chain | Both job_start records have non-null values and hash continuity | **Mapped** — Steps 3a/3b are the two calls |

AC mapping is correct and complete.

---

## 4. 5-Step Approach Feasibility

| Step | Description | Feasibility | Issue |
|------|-------------|-------------|-------|
| 1 | Probe bridge state (`blender_agent_environment_probe`) | ✅ Feasible | None |
| 2 | Probe audit log baseline | ✅ Feasible | None |
| 3 | Attempt correct chain — Step 3a + 3b | ✅ Executable | **Plan states Step 3b "THIS WILL FAIL — confirms defect"** |
| 4 | If bridge repaired during ticket, re-run Steps 3a–3b | ⚠️ Conditional | **No mechanism to trigger repair within this ticket** |
| 5 | Closeout evidence extraction | ❌ Blocked | Step 4 must succeed first |

**Step 3** is designed to *confirm the defect exists*, not to produce AC-meeting evidence. The expected failure confirms the problem but does not advance the ACs.

**Step 4** is aspirational — "if the bridge is repaired during this ticket" — with no executable path to trigger that repair.

**Step 5** cannot execute until Step 4 succeeds.

The 5-step approach is a diagnostic sequence, not an implementation sequence. It confirms the defect but does not resolve it.

---

## 5. Blocker Analysis

### BRIDGE-DEFECT (documented in plan)

**Status**: Correctly identified and documented.

**Impact**: The plan explicitly acknowledges "REMED-009 cannot close until the bridge is fixed." The plan also correctly maps the affected bridge file: `/home/pc/projects/blender-agent/mcp-server/src/blender_mcp_server/bridge_runtime.py`.

**Resolvability**: The bridge code is an external dependency. The plan has no in-ticket path to repair it.

### AC Reframe Gap (documented in plan)

**Status**: Identified as a contingency ("if the bridge cannot be repaired").

**Impact**: AC-2 demands "prove one correct chain" — but the defect prevents constructing that chain without bridge repair. The plan offers a fallback ("no new null-input_blend mutating calls after date X") but no decision has been made on this reframe.

**Decision required**: Either (a) repair the bridge and re-enter plan review, or (b) formally reframe AC-2 to a retrospective audit approach.

---

## 6. Risks and Assumptions

- **Risk**: Bridge defect is systemic — cannot be worked around from the agent side. Correctly identified.
- **Assumption**: Bridge at `bridge_runtime.py` can be updated. This is plausible but external to this ticket.
- **Assumption**: Audit log writes are synchronous — plausible, not validated by the plan.

---

## 7. Verdict

**Decision: REJECT**

### Reasons

1. **BRIDGE-DEFECT blocks AC-meeting proof**: The plan's Step 3 is designed to fail and confirm the defect. The actual AC-meeting evidence (non-null `input_blend` chain in audit log) cannot be produced until the bridge is repaired. Step 4 ("if bridge is repaired") is conditional with no executable path to trigger the repair.

2. **Plan cannot close as written**: The plan explicitly states "REMED-009 cannot close until the bridge is fixed." Since there is no mechanism within this ticket to fix the bridge, the plan documents the diagnostic path but not the resolution path.

3. **AC reframing decision not made**: The plan identifies that AC-2 may need reframing if the bridge cannot be repaired, but no decision has been made. Without that decision, the plan is incomplete.

4. **Step 5 (closeout evidence) is unreachable**: All 5 steps cannot be executed sequentially within this ticket's lifecycle. Steps 3–5 form a chain that breaks at Step 3.

### Required Revisions

1. **Resolve BRIDGE-DEFECT externally** — The bridge must be repaired before REMED-009 can proceed. This may require a separate repair ticket or user action. Once bridge repair is confirmed, re-enter plan_review with updated evidence.

2. **Formal AC reframe decision** — If bridge repair is not possible, the team must decide whether AC-2 should be reframed to: "no new null-input_blend mutating calls are recorded in the audit log after [date]" with a retrospective audit of post-fix calls. This decision is outside this ticket's scope.

3. **Revised plan must distinguish diagnostic vs. resolution steps** — The 5-step approach should separate: (a) confirmation of defect (Steps 1–3), (b) bridge repair trigger (external), (c) post-repair proof run (Step 4), (d) closeout (Step 5).

### Artifact Produced

- Review artifact: `.opencode/state/reviews/remed-009-review-review.md` (this document)
- Registered via: `artifact_register { kind: "review", stage: "review", ticket_id: "REMED-009" }`
- Workflow update: `ticket_update { ticket_id: "REMED-009", approved_plan: false }`

---

## 8. Findings

| Finding | Severity | Description |
|---------|----------|-------------|
| PLAN-DEFECT-CHAIN | **Critical** | The 5-step approach is a diagnostic loop that cannot produce AC-meeting closeout evidence without an external bridge repair |
| PLAN-AC-REFRAME-UNRESOLVED | **Major** | AC-2 fallback reframe identified but not decided |
| PLAN-NO-REPAIR-PATH | **Major** | No in-ticket mechanism to trigger bridge repair; BRIDGE-DEFECT is external |
| PLAN-STEP5-UNREACHABLE | **Major** | Step 5 (closeout evidence) requires Step 4 to succeed, which requires bridge repair, which is external |

---

## 9. Validation Gaps

1. The plan does not confirm whether bridge repair is possible within this ticket's lifecycle or requires external action.
2. The plan does not provide a decision path if AC reframing is chosen.
3. The plan does not validate that audit log writes are synchronous before relying on them for closeout evidence.

---

## 10. Summary

The REMED-009 planning artifact is thorough, well-documented, and correctly identifies the root cause and the BRIDGE-DEFECT blocker. However, it cannot execute to closeout as written because:

- The 5-step approach is a diagnostic sequence, not a resolution sequence.
- The bridge must be repaired before AC-meeting evidence can be produced.
- No in-ticket mechanism exists to trigger that repair.
- The AC reframing fallback remains undecided.

**REJECT — Revise with a bridge repair path or a formal AC reframing decision before re-entering plan_review.**