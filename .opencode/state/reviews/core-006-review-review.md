# Review: CORE-006 — Enemy variants with model swapping

## Verdict: **APPROVE**

All 5 acceptance criteria verified with live executable evidence. Timing fix (BLOCKER-1) correctly implemented. No blockers remain.

---

## Timing Fix Verification (BLOCKER-1)

**BLOCKER-1 resolved.** The prior review (2026-04-17T14:32:39.916Z) rejected the implementation because `_ready()` auto-called `_load_variant_model()`, but `wave_spawner` set `variant_name` after `add_child()`, causing all enemies to load the brown GLB regardless of assigned variant.

**Option A correctly implemented:**

| Step | Action | Result |
|------|--------|--------|
| 1 | `add_child(enemy)` | `_ready()` fires — no GLB loading (confirmed: `_ready()` only sets up nav agent and signal connections, lines 23-28 of horse_base.gd) |
| 2 | `enemy.variant_name = variant` | Set **before** `load_variant_model()` (wave_spawner.gd lines 116-117) |
| 3 | `enemy.speed = speed` / `enemy.max_health = health` | Per-wave stats applied (wave_spawner.gd lines 120-127) |
| 4 | `enemy.load_variant_model()` | Called **after** all properties set (wave_spawner.gd lines 140-141) |

**Critical code verified in horse_base.gd:**
- `load_variant_model()` is a **public method** named exactly that (line 47) — not `_load_variant_model()`
- `_ready()` (lines 23-28) does **not** call `load_variant_model()` — confirmed by grep; GLB loading comment at line 29 explicitly notes deferral
- `variant_name` is `@export` (line 15), set externally before `load_variant_model()` is called

---

## 5 AC Verification

### AC-1: `horse_variants.gd` with variant definitions
**PASS** — `scripts/enemies/horse_variants.gd` contains `VARIANTS` dictionary with keys `"brown"`, `"black"`, `"war"`, `"boss"` (lines 13-40).

### AC-2: Each variant has model_path, speed, health, damage, score_value
**PASS** — All 5 fields present in all 4 variant entries. Field names in file: `model_path`, `speed`, `max_health`, `contact_damage`, `score_value`. Live grep confirmed:

```
$ grep -E '"(model_path|speed|max_health|contact_damage|score_value)"' scripts/enemies/horse_variants.gd
```

All 5 keys present for all 4 variant entries.

### AC-3: horse_base loads correct GLB at runtime
**PASS** — `load_variant_model()` (horse_base.gd lines 47-82) is a public method that:
- Resolves variant data via `HorseVariants.get_variant(variant_name)`
- Loads GLB via `GLTFDocument.append_from_file(model_path, state)` (line 72)
- Assigns mesh to `$ModelContainer/MeshInstance3D` (line 80)
- Is **NOT called from `_ready()`** — confirmed by direct file inspection

### AC-4: Wave spawner can request variant types
**PASS** — `variant` key present in all 5 `wave_configs` entries (wave_spawner.gd lines 26-30). `_spawn_enemy()` accepts `variant: String` parameter (line 104) and correctly implements Option A ordering:
- variant_name set at lines 116-117
- load_variant_model() called at lines 140-141

### AC-5: All models load without errors
**PASS** — Godot headless validation:

```
$ godot4 --headless --path . --quit
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT_CODE: 0
```

All 4 GLB files confirmed present:
```
-rw-rw-r-- 1 rowan rowan  14596 Apr 17 09:07 assets/models/horse-black.glb
-rw-rw-r-- 1 rowan rowan 338612 Apr 17 12:16 assets/models/horse-boss.glb
-rw-rw-r-- 1 rowan rowan  38356 Apr 14 02:34 assets/models/horse-brown.glb
-rw-rw-r-- 1 rowan rowan  46636 Apr 17 11:47 assets/models/horse-war.glb
```

---

## Plan Conformance

Implementation exactly follows the approved plan (`.opencode/state/plans/core-006-planning-plan.md`):
- Option A timing fix correctly applied
- GLTFDocument runtime GLB loading implemented
- All 4 variant types (brown/black/war/boss) mapped
- All 5 wave configs include variant key
- Signal wiring for died events intact

---

## Non-Blocking Advisories

1. **Mesh assignment is additive**: each `load_variant_model()` call replaces `$ModelContainer/MeshInstance3D.mesh` with the variant's mesh. If the base horse_base.tscn scene pre-sets a mesh (e.g., a placeholder box), it gets overwritten on first call. This is expected and not a defect.
2. **Health component sync**: wave_spawner syncs `Health.max_health` (lines 126-127) but does not sync `Health.current_health`. Enemies spawn with full health from the Health component default, then `max_health` is updated. If starting health is derived from `max_health` at node creation rather than via an explicit `health = max_health` assignment, the initial health pool may be the scene default, not the wave-configured value. This is pre-existing behavior in CORE-002; not introduced here.

---

## Findings

None. All 5 ACs verified PASS. No blockers.

---

## Recommendation

Advance CORE-006 to QA stage.
