# Backlog Verification — CORE-004: 3D HUD (CanvasLayer)

## Ticket

| Field | Value |
|---|---|
| ID | CORE-004 |
| Title | 3D HUD (CanvasLayer) |
| Wave | 2 |
| Lane | ui |
| Stage | closeout |
| Status | done |
| Resolution | done |
| Verification (pre-verification) | trusted |

---

## Process Context

| Field | Value |
|---|---|
| Process version | 7 |
| Process change summary | Managed Scafforge repair runner refreshed deterministic workflow surfaces and evaluated downstream repair obligations |
| `pending_process_verification` at check time | true |
| `latest_backlog_verification` pre-existing | **null** — no prior backlog verification artifact existed |
| Bootstrap status | ready (environment fingerprint: `8e35836e…`) |
| `repair_follow_on.outcome` | `source_follow_up` (non-blocking for lifecycle routing) |

---

## Verification Verdict

**PASS** — All 5 acceptance criteria verified with current live executable evidence. No material proof gaps. No workflow drift. Trust restoration recommended for process version 7.

---

## Acceptance Criteria Verification (Live Evidence)

### AC-1: `hud.tscn exists with CanvasLayer root`

| Check | Evidence |
|---|---|
| File exists | `glob scenes/ui/hud.tscn` → `/home/rowan/womanvshorseVC/scenes/ui/hud.tscn` ✅ |
| CanvasLayer root | Line 9 of hud.tscn: `[node name="HUD" type="CanvasLayer"]` ✅ |
| Godot loadable | `godot4 --headless --path . --quit` → EXIT:0 ✅ |

**AC-1: PASS**

---

### AC-2: `Displays health, wave, score, enemy count`

| Check | Evidence |
|---|---|
| Health display | `HealthLabel` ("HP") + `HealthBar` (ProgressBar, max=100, value=100) — hud.tscn lines 23–32 ✅ |
| Wave display | `WaveLabel` ("Wave 1") — hud.tscn line 48 ✅ |
| Enemy count | `EnemyCountLabel` ("Enemies: 0") — hud.tscn line 54 ✅ |
| Score display | `ScoreLabel` ("Score: 0") — hud.tscn line 69 ✅ |

**AC-2: PASS**

---

### AC-3: `Virtual joystick and attack button placeholders`

| Check | Evidence |
|---|---|
| JoystickArea | `Area2D` with `virtual_joystick.gd` script attached — hud.tscn lines 72–74 ✅ |
| JoystickBase | `Panel` 100×100 — hud.tscn lines 79–84 ✅ |
| JoystickNub | `Panel` 40×40 visual nub — hud.tscn lines 86–96 ✅ |
| AttackButton | `Area2D` with `attack_button.gd` script attached — hud.tscn lines 98–100 ✅ |
| AttackLabel | `Label` "ATK" 80×80 — hud.tscn lines 105–113 ✅ |
| Scripts present | All 5 scripts in `scripts/ui/`: `health_display.gd`, `wave_display.gd`, `score_display.gd`, `virtual_joystick.gd`, `attack_button.gd` ✅ |

**AC-3: PASS**

---

### AC-4: `Touch-friendly sizing (48dp minimum)`

| Check | Evidence |
|---|---|
| JoystickBase touch zone | `custom_minimum_size = Vector2(100, 100)` — hud.tscn line 80 (100×100 > 48dp ✅) |
| AttackButton touch zone | `custom_minimum_size = Vector2(80, 80)` — hud.tscn line 106 (80×80 > 48dp ✅) |
| CircleShape2D joystick | radius = 50.0 — hud.tscn line 116 ✅ |
| CircleShape2D attack | radius = 40.0 — hud.tscn line 119 ✅ |

**AC-4: PASS**

---

### AC-5: `Scene loads without errors`

| Check | Evidence |
|---|---|
| Godot headless | `godot4 --headless --path /home/rowan/womanvshorseVC --quit` → EXIT:0, no errors ✅ |
| Duration | 162 ms |

**AC-5: PASS**

---

## Workflow Drift Check

| Dimension | Status |
|---|---|
| Stage sequence (plan → review → implement → QA → smoke-test → closeout) | All stages completed in correct order ✅ |
| Artifact completeness | plan ✅, implementation ✅, review ✅, QA ✅, smoke-test ✅ |
| `verification_state` before this verification | `trusted` (not reverted or suspect) ✅ |
| `resolution_state` before this verification | `done` ✅ |
| Dependency status | `SETUP-001` (done/trusted) ✅ |
| Post-process-change evidence freshness | Smoke-test artifact `.opencode/state/smoke-tests/core-004-smoke-test-smoke-test.md` predates process change; live verification confirms still valid ✅ |

**No workflow drift detected.**

---

## Proof Gap Assessment

| Gap | Finding |
|---|---|
| Prior backlog-verification artifact | None existed (null) — this is the first backlog verification for CORE-004 ✅ |
| Evidence freshness | Live godot validation confirms current state matches registered artifact state ✅ |
| Process version compatibility | CORE-004 has no Blender-MCP, Android export, or scaffolding tool dependencies; the process version 7 change does not affect this ticket's implementation surface ✅ |
| Bootstrap state | Bootstrap ready, environment fingerprint matches latest bootstrap proof ✅ |

**No material proof gaps.**

---

## Findings by Severity

**None.** All 5 ACs verified PASS with current live evidence. No defects, no drift, no gaps.

---

## Recommendation

Trust restoration is recommended. No blockers exist for `ticket_reverify` on CORE-004.

---

## Canonical Artifact Path

`.opencode/state/reviews/core-004-review-backlog-verification.md`
