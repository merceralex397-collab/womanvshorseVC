# QA Artifact: REMED-002 — Remediation Review Artifact Command Evidence

## Ticket
- **ID:** REMED-002
- **Title:** Remediation review artifact does not contain runnable command evidence
- **Stage:** qa
- **Lane:** remediation
- **Wave:** 5
- **Finding Source:** EXEC-REMED-001

---

## QA Objective

Verify that EXEC-REMED-001 no longer reproduces. EXEC-REMED-001 flagged that the REMED-001 review artifact cited implementation artifact evidence instead of containing direct command output.

The fix was to regenerate the REMED-001 review artifact with direct command evidence recorded in the review artifact itself.

---

## Commands Run

### Command 1: `godot --version`

**Full raw output:**
```
4.6.2.stable.official.71f334935
```

**Exit code:** 0

---

### Command 2: `godot --headless --path /home/pc/projects/womanvshorseVC --quit`

**Full raw stdout:**
```
Error: Can't run project: no main scene defined in the project.
Error: Can't run project: no main scene defined in the project.

```

**Exit code:** 1

Note: The exit code 1 is expected — it reflects Godot's project validation that no main scene is defined, not a binary-access or PATH failure. This is the same "expected failure" documented in the REMED-001 review artifact.

---

## Acceptance Criteria Verification

### AC-1: EXEC-REMED-001 no longer reproduces

**Original finding (EXEC-REMED-001):** The REMED-001 review artifact cited implementation artifact evidence rather than containing direct command output in the review artifact itself.

**Current state:** The regenerated REMED-001 review artifact (`.opencode/state/reviews/remed-001-review-review.md`) now contains:
- Line 74: **Command run:** `godot --headless --path /home/pc/projects/womanvshorseVC --quit`
- Lines 120–124: Raw STDOUT, STDERR, and EXIT_CODE recorded directly
- Lines 44–48: Direct evidence chain for both ACs

The review artifact now cites its own direct command output, not implementation artifact output.

**Result: PASS** — EXEC-REMED-001 does not reproduce.

---

### AC-2: Review artifact records exact command run, raw output, and explicit PASS/FAIL result

**Requirement:** For remediation tickets with `finding_source`, the review artifact must record:
1. The exact command run
2. Raw command output
3. Explicit PASS/FAIL result before the review counts as trustworthy closure

**Verification against `.opencode/state/reviews/remed-001-review-review.md`:**
- **Exact command run:** Yes — line 74 records `godot --headless --path /home/pc/projects/womanvshorseVC --quit`
- **Raw command output:** Yes — lines 120–124 record STDOUT, STDERR, and EXIT_CODE
- **Explicit PASS/FAIL result:** Yes — line 15–16: "**Result: PASS**" for AC-1; line 42: "**Result: PASS**" for AC-2; line 107: "**Verdict: APPROVE**"

The regenerated review artifact meets all three requirements.

**Result: PASS**

---

## Final QA Verdict

| Acceptance Criterion | Result |
|---------------------|--------|
| AC-1: EXEC-REMED-001 no longer reproduces | **PASS** |
| AC-2: Review artifact has direct command evidence with PASS/FAIL | **PASS** |

**Overall QA Result: PASS**

The regenerated REMED-001 review artifact now contains direct command evidence (not just implementation artifact citation), and both QA acceptance criteria for REMED-002 are satisfied.

---

## Raw Command Evidence Summary

**Command 1:**
- Command: `godot --version`
- Output: `4.6.2.stable.official.71f334935`
- Exit code: 0

**Command 2:**
- Command: `godot --headless --path /home/pc/projects/womanvshorseVC --quit`
- Output: `Error: Can't run project: no main scene defined in the project.`
- Exit code: 1 (expected — no scenes defined yet)

Both commands executed successfully at the binary level. The error output is expected project state (no main scene defined), not a binary-access failure.
