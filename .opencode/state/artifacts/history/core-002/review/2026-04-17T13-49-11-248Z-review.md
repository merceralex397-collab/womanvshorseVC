# Review: CORE-002 — Create 3D enemy horse base class

## Verdict: APPROVE

All 6 acceptance criteria verified PASS with live evidence.

---

## AC Verification

| AC | Criterion | Evidence | Result |
|----|-----------|----------|--------|
| AC-1 | horse_base.tscn exists with CharacterBody3D root | `scenes/enemies/horse_base.tscn` line 14: `[node name="HorseBase" type="CharacterBody3D"]` | **PASS** |
| AC-2 | horse_base.gd with 4 exported stats | `scripts/enemies/horse_base.gd` lines 8-11: `@export var speed`, `@export var max_health`, `@export var contact_damage`, `@export var score_value` | **PASS** |
| AC-3 | NavigationAgent3D for pathfinding | `horse_base.tscn` line 20: `[node name="NavigationAgent3D" type="NavigationAgent3D" parent="."]`; `horse_base.gd` uses `is_target_reachable()`, `get_target_position()`, `set_target_position()` | **PASS** |
| AC-4 | Health system with died signal | `HealthComponent.gd` line 6: `signal died`; line 19: `died.emit()` when `current_health <= 0`; `horse_base.gd` line 5 re-declares `signal died` and connects Health child: `Health.died.connect(died.emit)` — propagation chain correct | **PASS** |
| AC-5 | Contact damage via Area3D | `horse_base.tscn` lines 27-31: `ContactDamageArea` (Area3D) + CollisionShape3D child; `horse_base.gd` lines 22, 43-45: `body_entered.connect(_on_contact_body_entered)` → `body.take_damage(contact_damage)` guard with `has_method` check | **PASS** |
| AC-6 | Scene loads without errors | `godot4 --headless --path . --quit` → `EXIT_CODE=0` | **PASS** |

---

## Findings

### No Blockers

- All 6 ACs mapped to verifiable file evidence and executable validation.
- Godot headless exit code 0 confirms scene loads without errors.
- Health component (HealthComponent.gd) correctly emits `died` signal on `take_damage` when health depletes; HorseBase propagates it via `Health.died.connect(died.emit)` — proper signal chain for spawner/wave system wiring in downstream tickets.
- Contact damage Area3D guarded with `has_method("take_damage")` check — correctly scoped for CORE-003/CORE-005 player wiring.

### Advisory Notes (Non-blocking)

1. **NavigationAgent3D.max_speed sync**: `horse_base.gd` line 21 sets `_nav_agent.max_speed = speed` in `_ready()` — correctly synchronizes exported speed to navigation agent per plan risk mitigation.
2. **XZ-plane movement**: `velocity.y = 0.0` enforced each frame (line 32) — correct for top-down orthographic camera alignment per spec.
3. **Health component isolation**: HealthComponent.gd attached to a child Node named `Health`, not the CharacterBody3D itself — per plan design, leaves room for variant-specific health overrides in subclasses.
4. **Contact damage contract**: `ContactDamageArea` calls `body.take_damage(contact_damage)` — downstream CORE-005 must wire player to expose `take_damage(float) -> bool`.

---

## Compile/Import Check

```
godot4 --headless --path . --quit
Godot Engine v4.6.1.stable.official.14d19694e
EXIT_CODE=0
```

---

**Overall Result: PASS**
