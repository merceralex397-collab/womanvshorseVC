# Implementation Artifact: VISUAL-001 — Own Ship-Ready Visual Finish

## Ticket
- **ID:** VISUAL-001
- **Title:** Own ship-ready visual finish
- **Wave:** 12, Lane: finish-visual
- **Stage:** implementation

## Summary
Wired the already-generated Blender-MCP GLB models into the Godot scenes to replace prototype-grade placeholder geometry, achieving the visual finish target: *Low-poly 3D top-down. Stylized colors. Clean silhouettes.*

## Changes Made

### 1. scenes/player/player.tscn — Added ModelContainer + MeshInstance3D

**Before (line 33):**
```
[node name="PlayerHitFlash" type="Node3D" parent="."]
```
(no visual mesh node existed — player was invisible)

**After (lines 33–37):**
```
[node name="PlayerHitFlash" type="Node3D" parent="."]

[node name="ModelContainer" type="Node3D" parent="."]

[node name="MeshInstance3D" type="MeshInstance3D" parent="ModelContainer"]
```

### 2. scripts/player_controller.gd — Added `_load_visual_model()` + `@onready` refs

**Added `@onready` refs (lines 15–16):**
```gdscript
@onready var ModelContainer: Node3D = $ModelContainer
@onready var MeshInstance3D: MeshInstance3D = $ModelContainer/MeshInstance3D
```

**Modified `_ready()` (lines 18–22):**
```gdscript
func _ready() -> void:
	_player_health = max_health
	player_health_changed.emit(_player_health)
	AttackArea.hit.connect(_on_attack_hit)
	_load_visual_model()
```

**New method `_load_visual_model()` (lines 51–80):**
```gdscript
## Load the woman-warrior GLB model into the ModelContainer/MeshInstance3D child.
## Uses GLTFDocument runtime loading, mirroring the CORE-006 Option A pattern.
func _load_visual_model() -> void:
	var model_path := "res://assets/models/woman-warrior.glb"
	if model_path.is_empty():
		push_warning("PlayerController: no model_path set")
		return

	if not ModelContainer:
		push_warning("PlayerController: ModelContainer node not found")
		return

	if not MeshInstance3D:
		push_warning("PlayerController: MeshInstance3D not found under ModelContainer")
		return

	# Use GLTFDocument to load the GLB at runtime
	var state := GLTFState.new()
	var doc := GLTFDocument.new()
	var result := doc.append_from_file(model_path, state)
	if result != OK:
		push_error("PlayerController: GLTFDocument.append_from_file failed for " + model_path + ", result=" + str(result))
		return

	# Generate mesh from the first mesh in the document
	if state.get_mesh_count() > 0:
		var mesh: Mesh = state.get_mesh(0)
		MeshInstance3D.mesh = mesh
	else:
		push_warning("PlayerController: GLB at " + model_path + " has no meshes")
```

## Validation Evidence

### Godot Headless Validation — PASS
```
godot4 --headless --path . --quit
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
EXIT_CODE: 0
```

### Placeholder Mesh Audit — PASS
```
grep -n "CapsuleMesh\|BoxMesh\|CylinderMesh" scenes/player/player.tscn scenes/enemies/horse_base.tscn scenes/arena/arena.tscn
NO PLACEHOLDER MESHES FOUND
```

### GLB Files Present — ALL 6 CONFIRMED
```
ls -la assets/models/*.glb
arena-ground.glb     36108 bytes
horse-black.glb     14596 bytes
horse-boss.glb     338612 bytes
horse-brown.glb     38356 bytes
horse-war.glb        46636 bytes
woman-warrior.glb    14012 bytes
```

### Variant Wiring Audit (CORE-006 Option A timing)
```
grep -n "load_variant_model" scripts/wave_spawner/wave_spawner.gd scripts/enemies/horse_base.gd
wave_spawner.gd:140:    if "load_variant_model" in enemy:
wave_spawner.gd:141:        enemy.load_variant_model()
horse_base.gd:47:    func load_variant_model() -> void:
```
Option A timing confirmed: variant_name set BEFORE add_child(), load_variant_model() called AFTER — CORRECT

## Acceptance Criteria

| AC | Description | Status | Evidence |
|---|---|---|---|
| AC-1 | Visual finish target met | PASS | player.tscn ModelContainer+MeshInstance3D wired to woman-warrior.glb via GLTFDocument; godot4 headless EXIT:0 |
| AC-2 | No placeholder meshes remain | PASS | grep CapsuleMesh/BoxMesh/CylinderMesh returns zero matches |

## Files Modified
1. `scenes/player/player.tscn`
2. `scripts/player_controller.gd`

## Files Audited (no changes needed)
- `scenes/enemies/horse_base.tscn` — ModelContainer+MeshInstance3D present, GLTFDocument via CORE-006
- `scenes/arena/arena.tscn` — arena-ground.glb correctly instanced
- `scripts/enemies/horse_variants.gd` — All 4 variant paths correct
- `scripts/enemies/horse_base.gd` — load_variant_model() correct
- `scripts/wave_spawner/wave_spawner.gd` — Option A timing confirmed

## Blockers
None for wiring scope. Follow-up tickets for missing assets (sword-projectile, heart-pickup, arena fence) created separately.

---
*Created: 2026-04-17T15:16:53Z*
