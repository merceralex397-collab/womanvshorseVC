# Plan: CORE-006 — Enemy variants with model swapping (revised)

## 1. Scope

Deliver a working variant system for 4 enemy horse types (brown, black, war, boss) that:
- Configures each variant with unique stats and a specific GLB model path
- Loads the correct GLB model at runtime into `horse_base` instances
- Lets `wave_spawner` request a named variant per spawn, with variant assignments per wave

**In scope**: `horse_variants.gd`, modifications to `horse_base.gd` (variant export + explicit model loading method), modifications to `wave_spawner.gd` (variant-aware spawn), scene/script validation.
**Out of scope**: New Blender-MCP model generation (all 5 GLBs already exist), gameplay tuning, audio, UI wiring beyond what's needed to exercise variants.

---

## 2. Variant Definitions

File: `scripts/enemies/horse_variants.gd`

Defines a `VARIANTS` dictionary mapping variant name → stat dictionary.

| Variant | model_path | speed | max_health | contact_damage | score_value |
|---------|-----------|-------|------------|----------------|-------------|
| brown   | `res://assets/models/horse-brown.glb` | 2.5 | 80.0 | 10.0 | 100 |
| black   | `res://assets/models/horse-black.glb` | 4.0 | 60.0 | 15.0 | 150 |
| war     | `res://assets/models/horse-war.glb`   | 2.0 | 150.0 | 25.0 | 250 |
| boss    | `res://assets/models/horse-boss.glb`  | 1.5 | 300.0 | 40.0 | 1000 |

Rationale: Stats are tuned relative to the 5-wave progressive difficulty already in `wave_spawner.gd`. Black is fast/fragile. War is slow/tanky. Boss is a wave-5 anchor. Brown is the mid-tier baseline.

---

## 3. Files / Systems Affected

| File | Change |
|------|--------|
| `scripts/enemies/horse_variants.gd` | **New** — `VARIANTS` dictionary + `get_variant(variant_name)` accessor |
| `scripts/enemies/horse_base.gd` | **Modified** — add `@export var variant_name: String = "brown"`, move GLB loading from `_ready()` into explicit `load_variant_model()` method |
| `scripts/wave_spawner/wave_spawner.gd` | **Modified** — add `variant` field to each `wave_configs` entry, update `_spawn_enemy` to (a) set `variant_name` before calling `load_variant_model()` and (b) call `load_variant_model()` after all properties are set |
| `scenes/enemies/horse_base.tscn` | **No change** — base scene remains clean; GLB is loaded at runtime as child MeshInstance3D |

---

## 4. Timing Resolution — The Blocking Defect (REV-1)

### Root Cause (from prior review)

The prior plan placed `_load_variant_model()` inside `_ready()`. The spawn sequence was:

```
var enemy = enemy_scene.instantiate()
enemy_container.add_child(enemy)   ← _ready() fires → _load_variant_model() reads variant_name="brown" (default)
enemy.variant_name = variant       ← variant_name set AFTER add_child → wrong variant loaded
```

**Result**: All enemies load the brown GLB regardless of their assigned variant. This is a blocking defect. The prior plan's risk register acknowledged it as "Medium likelihood" but provided no concrete mitigation and the Blockers section incorrectly stated "None."

### Resolution: Option A — Explicit Post-Setup `load_variant_model()` Call

Remove `_load_variant_model()` from `_ready()`. Make it a public `load_variant_model()` method. The wave_spawner calls it **after** setting all properties including `variant_name`.

Corrected spawn sequence:

```
var enemy = enemy_scene.instantiate()
enemy_container.add_child(enemy)   ← _ready() fires (no GLB loading)
enemy.variant_name = variant       ← variant_name set FIRST
enemy.speed = speed                ← other properties set
enemy.max_health = health
enemy.load_variant_model()         ← GLB loads AFTER all properties are set → correct variant
```

**Why Option A over Options B/C:**
- Option B (`call_deferred` inside horse_base): Defers the entire GLB load but does not solve the property-assignment ordering problem — `call_deferred` runs after the current frame's code, but `variant_name` must still be set before the deferred call executes. Would require an extra frame or an explicit ordering guarantee that Option A makes unnecessary.
- Option C (`defer_model_load` flag): Adds a state flag that must be kept in sync; less clean than an explicit call chain.
- Option A is explicit: the caller controls exactly when GLB loading occurs after property setup. No hidden timing dependencies.

---

## 5. Scene / Script Design

### 5.1 `horse_variants.gd` (new)

```gdscript
class_name HorseVariants
extends RefCounted

const VARIANTS: Dictionary = {
    "brown": {
        "model_path": "res://assets/models/horse-brown.glb",
        "speed": 2.5,
        "max_health": 80.0,
        "contact_damage": 10.0,
        "score_value": 100,
    },
    "black": {
        "model_path": "res://assets/models/horse-black.glb",
        "speed": 4.0,
        "max_health": 60.0,
        "contact_damage": 15.0,
        "score_value": 150,
    },
    "war": {
        "model_path": "res://assets/models/horse-war.glb",
        "speed": 2.0,
        "max_health": 150.0,
        "contact_damage": 25.0,
        "score_value": 250,
    },
    "boss": {
        "model_path": "res://assets/models/horse-boss.glb",
        "speed": 1.5,
        "max_health": 300.0,
        "contact_damage": 40.0,
        "score_value": 1000,
    },
}

static func get_variant(name: String) -> Dictionary:
    return VARIANTS.get(name, VARIANTS["brown"])
```

### 5.2 `horse_base.gd` — Revised GLB Loading Design

**Key change**: `_load_variant_model()` is NO LONGER called from `_ready()`. It is a public method called by `wave_spawner` after all properties are set.

```gdscript
@export var variant_name: String = "brown"   # set by wave spawner before calling load_variant_model()

func _ready() -> void:
    # ... existing code (health, nav, contact damage setup) ...
    # NOTE: GLB loading is NOT called here. It is deferred to load_variant_model()
    # which must be called by wave_spawner AFTER variant_name and other stats are set.
    pass

# Called by wave_spawner AFTER all properties (variant_name, speed, health) are set.
func load_variant_model() -> void:
    var variant = HorseVariants.get_variant(variant_name)
    var model_path: String = variant["model_path"]
    
    var gltf := GLTFDocument.new()
    var ret := gltf.append_from_file(model_path, -1)
    if ret != OK:
        push_warning("HorseBase: failed to load GLB at " + model_path)
        return
    
    var state := gltf.generate_state()
    if state.meshes.size() == 0:
        push_warning("HorseBase: GLB has no meshes at " + model_path)
        return
    
    var mesh_instance := MeshInstance3D.new()
    mesh_instance.name = "VariantMesh"
    mesh_instance.mesh = state.meshes[0].mesh
    add_child(mesh_instance)
```

The GLB is loaded as a child `MeshInstance3D` named `VariantMesh`. The base scene's `CollisionShape3D` remains the physics body; visual representation comes from the GLB mesh. This avoids modifying the packed scene resource.

### 5.3 `wave_spawner.gd` — Corrected Variant-Aware Spawn

Update `wave_configs` to include `variant` and correct the `_spawn_enemy` order:

```gdscript
@export var wave_configs: Array[Dictionary] = [
    { count = 3, speed = 2.0,  max_health = 60.0,  spawn_radius = 9.0,  variant = "brown" },
    { count = 3, speed = 2.5,  max_health = 80.0,  spawn_radius = 9.5,  variant = "brown" },
    { count = 4, speed = 3.0,  max_health = 100.0, spawn_radius = 10.0, variant = "black" },
    { count = 5, speed = 3.5,  max_health = 120.0, spawn_radius = 10.5, variant = "war"   },
    { count = 5, speed = 4.0,  max_health = 150.0, spawn_radius = 11.0, variant = "boss"  },
]

func _spawn_enemy(spawn_pos: Vector3, speed: float, health: float, variant: String) -> void:
    var enemy: Node3D = enemy_scene.instantiate()
    _enemy_container.add_child(enemy)   # _ready() fires here — no GLB loading occurs

    # Apply variant + stats BEFORE calling load_variant_model()
    if "variant_name" in enemy:
        enemy.variant_name = variant
    if "speed" in enemy:
        enemy.speed = speed
    if "max_health" in enemy:
        enemy.max_health = health
        var health_node = enemy.get_node_or_null("Health")
        if health_node and "max_health" in health_node:
            health_node.max_health = health

    # Now load the correct GLB — variant_name is already set
    if "load_variant_model" in enemy:
        enemy.load_variant_model()

    # ... rest of nav setup ...
    if enemy.has_method("setup_nav"):
        enemy.setup_nav(_player_global_position)

func _spawn_wave() -> void:
    var config = wave_configs[current_wave - 1]
    # ...
    for i in range(count):
        _spawn_enemy(spawn_pos, config["speed"], config["max_health"], config.get("variant", "brown"))
```

---

## 6. Implementation Steps

1. **Create `scripts/enemies/horse_variants.gd`** — define `VARIANTS` dict and `get_variant()` accessor. File must have `class_name HorseVariants`.

2. **Modify `scripts/enemies/horse_base.gd`**:
   - Add `@export var variant_name: String = "brown"` below existing exports
   - **Remove** any `_load_variant_model()` call from `_ready()` — GLB loading is NOT automatic
   - Add `load_variant_model()` as a public method (not private with underscore) — this is called by wave_spawner after all properties are set
   - Prepend `class_name HorseVariants` reference at top of file

3. **Modify `scripts/wave_spawner/wave_spawner.gd`**:
   - Update `wave_configs` array to add `variant` key to each entry per table in §5.3
   - Add `variant: String` parameter to `_spawn_enemy` signature
   - Update `_spawn_wave()` call to pass `config.get("variant", "brown")`
   - Inside `_spawn_enemy`, set `variant_name` **before** calling `load_variant_model()`
   - Add `enemy.load_variant_model()` call after all property assignments (variant_name, speed, health)

4. **Validate GLB file accessibility** — confirm all 4 GLB paths resolve under `res://` from project root.

5. **Run Godot headless validation** — `godot4 --headless --path . --quit` must exit 0.

---

## 7. AC Mapping

| AC | Evidence |
|----|----------|
| AC-1: `horse_variants.gd` with variant definitions | File exists, contains `VARIANTS` dict with keys `brown`/`black`/`war`/`boss`, each entry has `model_path`, `speed`, `max_health`, `contact_damage`, `score_value` |
| AC-2: Each variant has model_path, speed, health, damage, score_value | `grep` each of the 5 fields for all 4 variant entries in `horse_variants.gd` |
| AC-3: horse_base loads correct GLB at runtime | `horse_base.gd` has public `load_variant_model()` method; wave_spawner calls it after setting `variant_name`; child MeshInstance3D named `VariantMesh` added |
| AC-4: Wave spawner can request variant types | `wave_configs` entries have `variant` field; `_spawn_enemy` receives variant name, assigns `enemy.variant_name`, then calls `enemy.load_variant_model()` |
| AC-5: All models load without errors | `godot4 --headless --path . --quit` exit 0; no `push_warning`/`push_error` for GLB load failures in output |

---

## 8. Validation Plan

1. **File existence**: `ls scripts/enemies/horse_variants.gd` → pass if exists
2. **Variant dictionary completeness**: `grep` for each of the 4 variant names + 5 field keys → pass if all present
3. **horse_base variant export**: `grep "@export.*variant_name" scripts/enemies/horse_base.gd` → pass
4. **`load_variant_model` is public (not `_load_variant_model`)**: `grep "func load_variant_model" scripts/enemies/horse_base.gd` → pass; verify no `_load_variant_model` auto-call in `_ready()`
5. **GLTFDocument usage**: `grep "GLTFDocument" scripts/enemies/horse_base.gd` → pass
6. **VariantMesh child**: `grep "VariantMesh" scripts/enemies/horse_base.gd` → pass
7. **wave_spawner calls `load_variant_model` after variant_name**: `grep "load_variant_model" scripts/wave_spawner/wave_spawner.gd` → pass; order of operations in `_spawn_enemy` verified
8. **Godot headless**: `godot4 --headless --path . --quit` → exit 0

---

## 9. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| GLB path `res://` not resolvable at runtime from child scene context | Low | Runtime warning, no model shown | Use full `res://` path (already in `assets/models/`), tested via Godot headless |
| GLTFDocument.load_scene not available in Godot 4.6 | Low | Swap to `GLTFDocument.append_from_file` + `generate_state()` (verified available) | Use `append_from_file` + `generate_state().meshes[0].mesh` approach |
| **BLOCKER-1 (RESOLVED)**: `_ready()` fires before `variant_name` is set, causing wrong GLB to load | ~~Medium~~ RESOLVED | ~~All instances load brown GLB~~ | `load_variant_model()` is now **explicit public method** called by wave_spawner **after** setting `variant_name` and all other properties — no hidden timing dependency |
| Multiple GLB loads on same frame cause hitches | Low | Single-frame pause on boss spawn | Boss is wave 5 only (1-2 instances); not a concern for 3-5 normal enemies |
| CollisionShape3D does not match GLB bounding box | Low | Visual collision mismatch | Keep base CapsuleShape3D; GLB is visual-only; acceptable for prototype |
| wave_spawner uses same `enemy_scene` for all variants | N/A | No issue | `variant_name` is set + `load_variant_model()` called per-instance after instantiate; GLB loads per instance with correct variant |

---

## 10. Blockers

### BLOCKER-1: `_ready()` timing — RESOLVED

**Prior issue (from prior review)**: `_load_variant_model()` was called in `_ready()`, but `wave_spawner.gd` set `variant_name` after `add_child`. All enemies loaded brown GLB regardless of variant.

**Resolution**: GLB loading is now an **explicit public method** `load_variant_model()` in `horse_base.gd`. The wave_spawner calls it **after** setting `variant_name` and all other stats. The corrected spawn sequence is:

```
add_child(enemy)        → _ready() fires (no GLB loading)
enemy.variant_name = variant
enemy.speed = speed
enemy.health = health
enemy.load_variant_model()  → GLB loads with CORRECT variant_name
```

No timing ambiguity remains. `variant_name` is always set before `load_variant_model()` is called.

### Other blockers

- **Dependency check**: CORE-002, MODEL-001/002/003/004/005 must all be `done`/`trusted` before implementation. Current manifest shows all six are `done`/`trusted` or `reverified`/`done`. No blockers from dependency state.
- **Bootstrap**: `bootstrap.status` is `ready`. No bootstrap blocker.
- **Architectural**: All required GLB files exist in `assets/models/`. Godot 4.6 GLTFDocument API confirmed available. Wave spawner architecture supports per-spawn property assignment with explicit post-setup call.

(End of file — revised plan)
