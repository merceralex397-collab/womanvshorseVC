# QA Artifact: MODEL-007 — Generate sword-projectile via Blender-MCP

## QA Stage: qa
## Ticket ID: MODEL-007
## Date: 2026-04-18

---

## Verdict: FAIL — All 5 ACs FAIL due to managed external server blocker

---

## Bootstrap Status
- `environment_bootstrap` completed successfully at `2026-04-18T00:33:14.037Z`
- Bootstrap proof: `.opencode/state/artifacts/history/model-007/bootstrap/2026-04-18T00-33-14-037Z-environment-bootstrap.md`

---

## Godot Headless Validation (Baseline Check)
```
$ godot4 --headless --path /home/rowan/womanvshorseVC --quit
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT_CODE: 0
```
**Result: PASS** — Project loads cleanly without errors. The Godot scene stack is intact.

---

## AC Validation Results

| AC | Criterion | Result | Evidence |
|----|-----------|--------|----------|
| AC-1 | `assets/models/sword-projectile.glb` exists | **FAIL** | `ls: cannot access .../sword-projectile.glb: No such file or directory` |
| AC-2 | Triangle count ≤ 200 | **FAIL** | No model generated — nothing to measure |
| AC-3 | Manifold mesh, no inverted normals | **FAIL** | No model generated — cannot validate mesh |
| AC-4 | Imports into Godot without errors | **FAIL** | No GLB to import; Godot headless check on project (not GLB) passes independently |
| AC-5 | PROVENANCE.md entry added | **FAIL** | `grep -n "sword-projectile" assets/PROVENANCE.md` → NO_ENTRY |

---

## Root Cause Confirmation

**Confirmed managed external blocker**: The blender_agent MCP server v1 compatibility layer has a regression that prevents `input_blend`/`output_blend` blend path forwarding to Blender's `--background` command line for `scene_batch_edit` and related tools.

**Audit log evidence** (from implementation and review artifacts):
- All 6 `scene_batch_edit` job_start records in `audit_20260418.jsonl` show: `input_blend: null, output_blend: null`
- No `--background /path/to/input.blend` argument present in any `command_executed` array
- All `job_complete` records carry the pair of warnings: "No output_blend was provided...No input_blend was provided..."

**Plan conformance verified**: Implementation correctly followed the 7-step chained workflow with explicit blend forwarding (same pattern that succeeded for MODEL-003 on 2026-04-17). No implementation error found.

**Review verdict**: Review APPROVE — "Implementation correctly identified and documented the managed external blocker. No implementation error. All 5 ACs FAIL due to confirmed server-level blender_agent bug. Follow-up remediation required before MODEL-007 can close."

---

## QA Conclusion

**FAIL** — All 5 ACs fail due to a confirmed server-level blender_agent MCP server regression.

QA validates:
1. The project itself loads cleanly (EXIT:0) — no Godot-level issue
2. The sword-projectile GLB does not exist at `assets/models/sword-projectile.glb`
3. No PROVENANCE.md entry exists for sword-projectile
4. The blocker is definitively at the blender_agent server level (blend path forwarding failure), NOT in the MODEL-007 implementation
5. The implementation correctly followed the proven MODEL-003 pattern with explicit blend chaining

**This is a legitimate FAIL ticket caused by a managed external server blocker. QA validation is complete and correct.**

---

*QA artifact created: 2026-04-18T01:10:00Z*
*QA Engineer: wvhvc-tester-qa*
*Blocker classification: Managed External Server Blocker (blender_agent v1 compat regression)*