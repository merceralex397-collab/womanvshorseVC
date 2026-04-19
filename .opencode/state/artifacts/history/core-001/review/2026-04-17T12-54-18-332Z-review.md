# Review Artifact: CORE-001 — Implement 3D Attack System

## Review Metadata

| Field | Value |
|---|---|
| Ticket | CORE-001 |
| Stage | plan_review |
| Plan artifact | `.opencode/state/plans/core-001-planning-plan.md` |
| Review artifact | `.opencode/state/reviews/core-001-review-review.md` |
| Reviewer | wvhvc-plan-review |
| Date | 2026-04-17 |

---

## Decision

**APPROVE**

---

## Plan Review Findings

### AC Mapping Completeness — PASS

All 5 acceptance criteria are mapped to verifiable evidence in the plan:

| AC | Criterion | Mapped Evidence | Verification |
|---|---|---|---|
| AC-1 | attack_system.gd exists | File at `scripts/attack_system.gd` with `class_name AttackSystem` | `test -f && grep "class_name AttackSystem"` |
| AC-2 | Area3D hitbox detects collision layer 2 | `collision.mask = 0b100` in `_ready()` | `grep "collision.mask"` |
| AC-3 | Cooldown timer prevents spam | Timer child in `_ready()`, `attack()` guards on `is_stopped()` | `grep "Timer" && grep "is_stopped"` |
| AC-4 | Damage signal emitted on hit | `signal hit(enemy: Node3D)` declared + `hit.emit(body)` in `_on_body_entered` | `grep "signal hit" && grep "hit.emit"` |
| AC-5 | Scene loads without errors | `godot4 --headless --path . --quit` exits 0 | Direct godot command |

All 5 ACs have explicit grep-based or command-based evidence. No AC is left as a vague promise.

### Script Design — PASS

The `attack_system.gd` design (lines 47–110) is coherent:

- **`extends Area3D`**: AttackArea is already an Area3D per SETUP-002 placeholder, so this is correct binding.
- **`signal hit(enemy: Node3D)`**: Enemy reference passed through signal, enabling listeners to identify which enemy was hit — correct.
- **Cooldown via Timer child**: Timer is a proper Godot Node child created via `add_child(_timer)` in `_ready()`. This is cleaner than exposing a raw `wait_time` float. The `attack()` method guards on `_timer.is_stopped()`, ensuring one hit per cooldown window.
- **Collision mask = `0b100`**: Layer 2 detection correctly expressed. In Godot 4, `collision.mask` is a bitmask; `0b100` = decimal 4 = layer 2. Plan correctly explains the mapping in lines 104–109.
- **`collision.layer = 0`**: AttackArea itself does not occupy a collision layer — it only detects. Correct for a hitbox sensor.
- **Input wiring**: `player_controller.gd` calls `$AttackArea.attack()` on `Input.is_action_just_pressed("attack")`. Plan notes this is the only change needed to player_controller.

### Collision Layer / Mask Correctness — PASS

Enemy bodies are expected on layer 2. The plan references this in the collision layer table (lines 104–109). The mask `0b100` is correctly derived. The design correctly distinguishes between:
- `collision.layer` — what layer the AttackArea itself occupies (0, sensor only)
- `collision.mask` — what layers the AttackArea detects (layer 2 = enemies)

### Cooldown Timer Mechanism — PASS

The timer is implemented as a child node (`add_child(_timer)`) with `one_shot = true`. The `attack()` method calls `_timer.start()` only if `is_stopped()` returns true, preventing spam. During the timer window, `_on_body_entered` fires `hit.emit(body)`. The code on lines 86–88 checks `not _timer.is_stopped()` before emitting, so the guard is correctly placed.

### Godot Headless Validation — PASS

AC-5 explicitly maps to `godot4 --headless --path . --quit` with expected exit code 0. The smoke test section (lines 153–163) includes this check.

### Blocker Identification — PASS

The plan identifies one decision-required blocker on line 197:

> "AttackArea placeholder missing CollisionShape3D — **Decision required**: inspect `scenes/player/player.tscn` before implementation begins"

Upon inspection of the actual `player.tscn` scene file:
- `AttackArea` (line 15 of player.tscn) is declared as an empty `Area3D` node with no children
- No `CollisionShape3D` child exists under `AttackArea`

This is a legitimate blocker. The plan correctly defers this decision to implementation stage ("prefer scene file for visibility" — line 142). The plan does not pretend the collision shape is already present; it explicitly calls out the need to verify and add it.

### Risk Register — PASS

The plan's risk table (lines 178–184) covers four concrete risks:
1. Missing collision shape — Medium likelihood, medium impact, mitigation is checking the scene file
2. Missing `attack` input action — Medium, plan notes adding it to InputMap during implementation
3. Layer mask value confusion (4 vs 0b100) — Low, plan uses explicit `0b100` with rationale
4. Timer double-hit — Low, `is_stopped()` guard prevents double emission

The `attack` input action is not currently present in `project.godot` (confirmed by reading lines 1–16). The plan identifies this risk and assigns it a mitigation.

### Implementation Step Quality — PASS

The 9-step plan (lines 137–148) is specific and grounded in the actual scene state:
- Step 1: Write attack_system.gd with correct class
- Step 2: Attach script to AttackArea node
- Step 3: Add CollisionShape3D if missing — this is where the blocker surfaces
- Steps 4–5: Configure mask and Timer child
- Step 6: Verify/add attack InputMap action
- Step 7: Wire player_controller to call attack()
- Step 8: godot headless validation
- Step 9: QA checks

---

## Required Revisions

**None.** The plan correctly identifies all gaps, maps all 5 ACs to verifiable evidence, and does not defer critical design decisions to runtime.

---

## Advisory Notes

1. **AttackArea CollisionShape3D**: The scene has the placeholder but no shape. Implementation step 3 must add it. The plan correctly flags this.

2. **`attack` input action**: Not currently in `project.godot`. Plan correctly flags this as a medium-risk item with a mitigation path. Implementation must add the action before QA can pass AC-5 in a full-load scenario.

3. **Timer one-shot**: `timer.one_shot = true` is correctly set. The timer does not auto-repeat, so `is_stopped()` returns true after each cooldown completes, allowing the next attack.

---

## Validation Gaps

**None identified.** All 5 ACs are mapped with grep-based or command-based verification. The plan does not rely on placeholder responses, deferred runtime behavior, or vague assertions.

---

## Blockers

**None at plan_review stage.** The identified blocker (missing CollisionShape3D under AttackArea) is correctly attributed and deferred to implementation step 3 with a clear action. The plan does not silently assume it exists.

---

## Summary

CORE-001 planning artifact is solid. All 5 ACs are mapped with verifiable evidence. Script design is correct for a Godot 4 Area3D attack sensor with cooldown and signal. Collision layers are correctly specified. Godot headless validation is included. Risks are concrete with named mitigations. The one identified blocker (CollisionShape3D presence under AttackArea) is explicitly deferred to implementation with a clear action. No silent assumptions, no placeholder language, no deferred-critical-design decisions.

**Plan is approved for implementation.**