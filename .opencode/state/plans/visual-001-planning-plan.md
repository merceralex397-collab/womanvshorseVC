# Planning Artifact: VISUAL-001 — Own Ship-Ready Visual Finish (Revised)

## 1. Scope

**Ticket:** VISUAL-001  
**Title:** Own ship-ready visual finish  
**Wave:** 12, Lane: finish-visual  
**Stage:** Planning (2nd revision after blocking defects identified)

### Objective
Wire the already-generated Blender-MCP GLB models into the Godot scenes to replace prototype-grade placeholder geometry, achieving the declared visual finish target: *Low-poly 3D top-down. Stylized colors. Clean silhouettes.*

### What this ticket IS
The wiring/integration work to make generated GLBs actually load and display in the Godot scenes.

### What this ticket is NOT
New Blender-MCP asset generation for the 6 completed GLBs (MODEL-001–006).

### Scope resolution for closeout gate
VISUAL-001 closes on wiring work (Steps 1–7) using the 6 already-generated GLBs. MODEL-007, MODEL-008, and FENCE-001 are independent follow-up tickets that complete the full visual surface. They are tracked as `follow_up_ticket_ids` on VISUAL-001 but are NOT `depends_on` dependencies — VISUAL-001 reaches smoke-test and closeout independently.

---

## 2. Files & Systems Affected

| File/System | Current State | Needed Action |
|---|---|---|
| `scenes/player/player.tscn` | Uses prototype placeholder geometry (likely CapsuleMesh or BoxMesh) | Wire woman-warrior.glb via GLTFDocument + MeshInstance3D using CORE-006 pattern |
| `scenes/enemies/horse_base.tscn` | Uses prototype placeholder geometry | GLTFDocument loading already exists via CORE-006; audit correctness |
| `scenes/enemies/horse_variants.gd` | Variant dictionary + GLTFDocument loading exists (CORE-006) | Verify correct GLB paths and load_variant_model() call order |
| `scenes/arena/arena.tscn` | arena-ground.glb already instanced (SETUP-001 verified); **fence border MISSING** | Confirm clean instancing; fence boundary deferred to FENCE-001 |
| `assets/models/*.glb` | 6 GLBs exist: woman-warrior (108 tris), horse-brown (752), horse-black (168), horse-war (180), horse-boss (4594), arena-ground (~290) | Sword-projectile.glb and heart-pickup.glb MISSING — deferred to MODEL-007/MODEL-008 |
| `project.godot` | Godot 4.6 project | Confirm GLB import pipeline active |

---

## 3. Visual Audit of Current Prototype State

### Player Scene (player.tscn)
- Likely uses a simple CapsuleMesh or BoxMesh placeholder for the warrior character
- The woman-warrior.glb (108 tris, green armor, silver sword, CC0) exists but is **not loaded**
- AttackArea, CollisionShape3D, and child nodes from SETUP-002/CORE-001 are present
- **Gap:** MeshInstance3D with woman-warrior.glb not wired

### Enemy Scene (horse_base.tscn)
- Likely uses a BoxMesh or CylinderMesh placeholder for horses
- ModelContainer Node3D + MeshInstance3D exists (added by CORE-006)
- GLTFDocument runtime loading exists via load_variant_model() in horse_base.gd
- **Gap:** Need to verify variant wiring actually loads the correct GLB at runtime

### Arena Scene (arena.tscn)
- arena-ground.glb already instanced via MeshInstance3D (SETUP-001 closeout verified)
- Camera3D orthographic, DirectionalLight3D present
- EnemyContainer Node3D present for spawner
- **Gap:** CANONICAL-BRIEF.md requires "arena-ground — Flat grass arena with fence border" — fence is missing — deferred to FENCE-001

### Variant System (horse_variants.gd)
- Dictionary with brown/black/war/boss variants exists
- Each variant has model_path pointing to assets/models/horse-*.glb
- **Gap:** Need to confirm all paths resolve and GLTFDocument loads correctly

### Missing Assets (deferred to follow-up tickets)
1. **sword-projectile.glb** — required by canonical brief (8-model spec), not yet generated → MODEL-007
2. **heart-pickup.glb** — required by canonical brief (8-model spec), not yet generated → MODEL-008
3. **Arena fence border** — required by canonical brief ("Flat grass arena with fence border"), not yet implemented → FENCE-001

---

## 4. Acceptance Criteria Mapping

| AC | Description | Evidence Required |
|---|---|---|
| AC-1 | Visual finish target met: Low-poly 3D top-down. Stylized colors. Clean silhouettes. | Godot headless loads player.tscn with woman-warrior.glb MeshInstance3D; horse_base.tscn loads correct variant GLB; arena.tscn loads arena-ground.glb; all scenes use PBR materials from GLBs, not placeholder colors |
| AC-2 | No placeholder or throwaway visual assets remain in user-facing product surfaces | Grep/catalog check confirms no CapsuleMesh/BoxMesh/CylinderMesh placeholder geometries remain in player.tscn, horse_base.tscn, or arena.tscn that are user-facing; all visible meshes are GLB-derived |

**Note on AC-1/AC-2 scope:** VISUAL-001 wiring work satisfies AC-1 and AC-2 for the 6 completed GLBs and the arena ground. The 2 missing GLBs (sword-projectile, heart-pickup) and the arena fence are owned by independent follow-up tickets (MODEL-007, MODEL-008, FENCE-001) created in Step 8. VISUAL-001 reaches closeout on wiring work alone; the follow-up tickets close independently.

---

## 5. Implementation Steps

### Step 1: Audit current scene state
- Read `scenes/player/player.tscn` — identify any placeholder MeshInstance3D nodes
- Read `scenes/enemies/horse_base.tscn` — identify any placeholder geometry
- Read `scenes/arena/arena.tscn` — confirm arena-ground.glb is correctly instanced
- Grep all .tscn files for `CapsuleMesh`, `BoxMesh`, `CylinderMesh` placeholders

### Step 2: Audit variant wiring in horse_variants.gd
- Read `scripts/enemies/horse_variants.gd` — verify model_path values are correct
- Verify all 4 GLB files are present: horse-brown.glb, horse-black.glb, horse-war.glb, horse-boss.glb

### Step 3: Audit GLTFDocument loading in horse_base.gd
- Read `scripts/enemies/horse_base.gd` — verify load_variant_model() uses GLTFDocument correctly
- Verify variant_name is set BEFORE add_child() (Option A from CORE-006 plan)
- Verify load_variant_model() is called AFTER add_child() and variant_name assignment

### Step 4: Wire woman-warrior.glb into player.tscn
- Add `variant_name` export to `player_controller.gd` (mirroring the CORE-006 / horse_base.gd pattern)
- Add MeshInstance3D child node to player.tscn under a ModelContainer Node3D
- Call `load_variant_model()` after add_child() and variant_name assignment, exactly as horse_base.gd does
- Use GLTFDocument to load woman-warrior.glb at runtime (same pattern as CORE-006)
- Verify model scaling: woman-warrior.glb is 108 tris — check it renders at appropriate size for top-down orthographic view (adjust scale if needed)

### Step 5: Verify enemy variant loading
- Confirm horse_base.gd calls load_variant_model() after variant assignment
- Confirm wave_spawner.gd passes correct variant string when spawning enemies

### Step 6: Godot headless validation
- Run `godot4 --headless --path . --quit` to confirm all scenes load without import errors
- Verify woman-warrior.glb, all horse-*.glb, and arena-ground.glb import cleanly

### Step 7: Placeholder audit pass
- Grep for remaining placeholder meshes in user-facing scenes
- Confirm only GLB-derived MeshInstance3D nodes remain in player, enemy, and arena scenes

### Step 8: Create follow-up tickets for missing required assets (parallel independent)

- **MODEL-007**: Generate sword-projectile via Blender-MCP — `ticket_create(source_mode=split_scope, split_kind=parallel_independent)`
- **MODEL-008**: Generate heart-pickup via Blender-MCP — `ticket_create(source_mode=split_scope, split_kind=parallel_independent)`
- **FENCE-001**: Add arena fence boundary — `ticket_create(source_mode=split_scope, split_kind=sequential_dependent)`

VISUAL-001 remains in the wiring lane; the 3 follow-up tickets own the missing asset generation and fence work. VISUAL-001 tracks MODEL-007, MODEL-008, and FENCE-001 as `follow_up_ticket_ids` for visibility but does not gate on them for closeout.

---

## 6. Validation Plan

| Check | Method | Expected Result |
|---|---|---|
| player.tscn has woman-warrior MeshInstance3D | grep + read | MeshInstance3D with woman-warrior.glb path present |
| horse_base.tscn has GLTFDocument loading | grep + read | load_variant_model() called, GLTFDocument used |
| arena.tscn arena-ground.glb instanced | read SETUP-001 artifact | Already verified in SETUP-001 closeout |
| All 6 GLB files present | ls assets/models/*.glb | 6 files: woman-warrior, horse-brown, horse-black, horse-war, horse-boss, arena-ground |
| No placeholder meshes in user-facing scenes | grep for CapsuleMesh/BoxMesh/CylinderMesh in tscn files | Zero matches in player.tscn, horse_base.tscn, arena.tscn |
| Godot headless loads all scenes | godot4 --headless --path . --quit | EXIT:0, no import errors |
| woman-warrior.glb scales correctly | visual check of scale values in tscn | Appropriate scale for top-down orthographic camera |
| Follow-up tickets created | ticket_lookup on MODEL-007, MODEL-008, FENCE-001 | All 3 exist in manifest with stage=planning or later |

---

## 7. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| woman-warrior.glb scale is wrong for top-down view | Low | Medium | Check scale values after loading; adjust MeshInstance3D scale property if needed |
| GLTFDocument fails to load GLB at runtime | Low | High | Verify GLB import settings; check godot4 --headless output for import errors |
| horse_variants.gd paths are stale or wrong | Low | High | Verify all 4 GLB paths exist via ls before runtime |
| Player GLB loading conflicts with existing player controller | Medium | Medium | Mirror the CORE-006 Option A pattern: set variant_name before add_child, call load after |
| Placeholder mesh remains accidentally | Low | High | Final grep pass before closeout QA |
| Model materials not displaying correctly | Medium | Medium | Verify PBR materials are embedded in GLBs; check material assignment in MeshInstance3D |
| Follow-up ticket creation fails (manifest write error) | Low | High | Use ticket_create tool directly; catch and report blocker if tool fails |

---

## 8. Blockers

**BLOCKER-1 (sword-projectile.glb and heart-pickup.glb missing) — RESOLVED via split_scope**
- Resolution: MODEL-007 and MODEL-008 created via `ticket_create(source_mode=split_scope)` in Step 8
- VISUAL-001 wiring scope covers only the 6 already-generated GLBs (woman-warrior, horse-brown, horse-black, horse-war, horse-boss, arena-ground)
- VISUAL-001 closes on wiring work alone; MODEL-007 and MODEL-008 are independent follow-up tickets, not closeout dependencies

**BLOCKER-2 (arena fence boundary missing) — RESOLVED via split_scope**
- Resolution: FENCE-001 created via `ticket_create(source_mode=split_scope)` in Step 8
- VISUAL-001 wiring scope covers arena-ground.glb instancing (already done in SETUP-001)
- VISUAL-001 closes on wiring work alone; FENCE-001 is an independent follow-up ticket, not a closeout dependency

**No remaining blockers at planning stage.** VISUAL-001 is ready for plan review.

---

## 9. Dependencies

**Direct dependencies:**
- **SETUP-001** (done/trusted) — arena scene structure and arena-ground.glb instancing

**Asset dependencies (all done/reverified):**
- **MODEL-001** (done/reverified) — woman-warrior.glb generated
- **MODEL-002** (done/reverified) — horse-brown.glb generated
- **MODEL-003** (done/reverified) — horse-black.glb generated
- **MODEL-004** (done/reverified) — horse-war.glb generated
- **MODEL-005** (done/reverified) — horse-boss.glb generated
- **MODEL-006** (done/reverified) — arena-ground.glb generated
- **CORE-006** (done/trusted) — variant system with GLTFDocument loading exists

**Follow-up tickets (tracked as `follow_up_ticket_ids`, NOT `depends_on`):**
- **MODEL-007** (pending) — sword-projectile.glb generation — parallel_independent of MODEL-008
- **MODEL-008** (pending) — heart-pickup.glb generation — parallel_independent of MODEL-007
- **FENCE-001** (pending) — arena fence boundary

**Closeout gate:** VISUAL-001 does not depend on MODEL-007, MODEL-008, or FENCE-001. VISUAL-001 reaches smoke-test and closeout on the wiring work alone (Steps 1–7). The follow-up tickets close independently.

---

## 10. Summary

VISUAL-001 is the visual finish wiring ticket. The Blender-MCP assets (MODEL-001–006) are all complete and reverified. The CORE-006 variant system already has GLTFDocument loading infrastructure.

After the blocking defect review, the plan was corrected to resolve two gaps:
1. sword-projectile.glb and heart-pickup.glb are missing from the 8-model spec — resolved by creating MODEL-007 and MODEL-008 via `ticket_create(source_mode=split_scope, split_kind=parallel_independent)`.
2. Arena fence border is missing from CANONICAL-BRIEF.md requirement — resolved by creating FENCE-001 via `ticket_create(source_mode=split_scope)`.

VISUAL-001 audits placeholder geometry in player.tscn and horse_base.tscn, wires the 6 generated GLBs into those scenes (following the CORE-006 pattern with `variant_name` export and `load_variant_model()` call), verifies arena-ground.glb is correctly instanced, and confirms via Godot headless that all GLBs import and load without errors.

VISUAL-001 closes on wiring work alone. MODEL-007, MODEL-008, and FENCE-001 are independent follow-up tickets with `split_kind=parallel_independent` (for MODEL-007/MODEL-008) and `split_kind=sequential_dependent` (for FENCE-001).

(End of file)