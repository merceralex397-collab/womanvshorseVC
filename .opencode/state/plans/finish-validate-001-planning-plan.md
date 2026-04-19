# Planning Artifact — FINISH-VALIDATE-001: Validate Product Finish Contract

**Ticket:** FINISH-VALIDATE-001  
**Lane:** finish-validation  
**Wave:** 14  
**Stage:** planning  
**Plan date:** 2026-04-17T16:00:00Z  
**Status:** Supersedes prior planning artifact (2026-04-17T15-41-16-537Z)

---

## 1. Scope

Prove that the declared Product Finish Contract is satisfied with current runnable evidence before RELEASE-001 closeout. The finish validation is a **compile-time and structural validation** — APK runtime execution on physical Android hardware is outside the headless scope but is explicitly noted as required before ship.

### Product Finish Contract Targets (from CANONICAL-BRIEF.md)

| Target | Declaration |
|--------|-------------|
| deliverable_kind | Android game APK with 3D graphics |
| placeholder_policy | No placeholder models. Blender-MCP generated assets only. |
| visual_finish_target | Low-poly 3D top-down. Stylized colors. Clean silhouettes. |
| audio_finish_target | Minimal SFX from open sources or procedural. |
| content_source_plan | 3D models via blender-agent MCP. Audio from open sources. |
| licensing_or_provenance_constraints | AI-generated models (CC0). Full provenance tracking. |
| finish_acceptance_signals | APK compiles. 3D models import cleanly. All waves playable. |

### Ticket Dependencies (both resolved)

| Ticket | Stage | Status | Evidence |
|--------|-------|--------|----------|
| VISUAL-001 | closeout | done/reverified | woman-warrior.glb wired to player; 6 GLBs present; zero placeholder meshes; godot EXIT:0 |
| AUDIO-001 | closeout | done/trusted | AudioManager singleton with 5 procedural SFX; all 4 required touchpoints wired; godot EXIT:0 |

### Supporting Tickets (all done/trusted or done/reverified)

| Ticket | Relevance |
|--------|-----------|
| SETUP-001 | Arena scene with arena-ground.glb |
| SETUP-002 | Player controller with XZ movement |
| CORE-001 | Attack system with Area3D hitbox + cooldown |
| CORE-002 | Enemy base class with NavigationAgent3D + health + contact damage |
| CORE-003 | Wave spawner with 5-wave progressive difficulty + all signals |
| CORE-004 | HUD with health, wave, score, enemy count, virtual joystick, attack button |
| CORE-005 | Collision/damage wiring (player↔enemy), hit flash, death handling |
| CORE-006 | Variant system with GLTFDocument runtime GLB loading for 4 horse types |
| UI-001 | Title screen → arena.tscn transition |
| UI-002 | Game over/victory screen with score + wave reached |
| ANDROID-001 | Debug APK at build/android/womanvshorseVC-debug.apk (29,824,304 bytes) |
| MODEL-001 | woman-warrior.glb — 108 tris, GODOT-certified |
| MODEL-002 | horse-brown.glb — 752 tris, GODOT-certified |
| MODEL-003 | horse-black.glb — 168 tris, GODOT-certified |
| MODEL-004 | horse-war.glb — 180 tris, GODOT-certified |
| MODEL-005 | horse-boss.glb — 4,594 tris, GODOT-certified |
| MODEL-006 | arena-ground.glb — ~290 tris, GODOT-certified |

### Follow-up Tickets (NOT depends_on — not required for finish contract close)

- MODEL-007 (sword-projectile), MODEL-008 (heart-pickup), FENCE-001 (arena fence) are tracked as VISUAL-001 follow-ups. They expand the declared asset set but are NOT part of the minimum viable finish contract per the declared finish_acceptance_signals: "APK compiles. 3D models import cleanly. All waves playable." None of the follow-ups are named in those signals.

---

## 2. Files or Systems Affected

| File/Surface | Role |
|-------------|------|
| `build/android/womanvshorseVC-debug.apk` | APK runnable proof (ANDROID-001) |
| `assets/models/` | 6 GLB files (MODEL-001–006) |
| `assets/PROVENANCE.md` | Provenance tracking for all generated models |
| `project.godot` | Godot project with main_scene, collision layers, input actions, AudioManager autoload |
| `export_presets.cfg` | Android export preset (com.wvh.vc package) |
| `scenes/arena/arena.tscn` | Main arena scene with WaveSpawner |
| `scenes/player/player.tscn` | Player with woman-warrior.glb wired via GLTFDocument |
| `scenes/enemies/horse_base.tscn` | Enemy base with variant GLB loading (CORE-006 pattern) |
| `scenes/ui/title_screen.tscn` | Entry point |
| `scenes/ui/game_over_screen.tscn` | End state screen |

---

## 3. Acceptance Criteria Mapping

### AC-1: Finish proof artifact explicitly maps current evidence to the declared acceptance signals: APK compiles. 3D models import cleanly. All waves playable.

**APK Compiles — Evidence:**
- ANDROID-001 implementation (2026-04-17T14:03:39-714Z): APK at `build/android/womanvshorseVC-debug.apk` — 29,824,304 bytes
- ANDROID-001 QA (2026-04-17T14:08:16-811Z): APK structure verified — `AndroidManifest.xml` + `classes.dex` + `libs/`, package `com.wvh.vc`
- ANDROID-001 smoke-test PASS (2026-04-17T14:09:05-949Z)
- Godot export command used: `godot4 --headless --path . --export-debug "Android Debug" build/android/womanvshorseVC-debug.apk`

**3D Models Import Cleanly — Evidence:**
- VISUAL-001 QA (2026-04-17T15:26:45-322Z): GLB inventory — 6 files present in `assets/models/`
- VISUAL-001 QA: MeshInstance3D + GLTFDocument wiring confirmed in player.tscn and horse_base.tscn
- Each MODEL-* ticket (001–006) has review APPROVE + QA PASS + smoke-test PASS with GODOT-certified quality_validate (errors=0)
- Triangle counts: woman-warrior 108, horse-brown 752, horse-black 168, horse-war 180, horse-boss 4594, arena-ground ~290 — all within CANONICAL-BRIEF budgets

**All Waves Playable — Evidence:**
- CORE-003 implementation (2026-04-17T13:57:41-213Z): wave_spawner.gd with 5-wave configs, signals wave_started, wave_cleared, all_waves_complete
- CORE-003 QA PASS, smoke-test PASS
- 5-wave progressive difficulty: Wave 1 (2 horse-brown) → Wave 5 (6 horses + horse-boss)
- Arena edge spawn positions via `get_arena_edge_position()` confirmed in wave_spawner.gd

### AC-2: Finish proof includes explicit user-observable interaction evidence (controls/input, visible gameplay state or feedback, and brief-specific progression or content surfaces), not just export/install success.

**Controls/Input — Evidence:**
- SETUP-002: player_controller.gd XZ-plane move_and_slide() movement
- CORE-001: attack_system.gd with Area3D hitbox (collision.mask=0b100), cooldown Timer, `hit` signal
- CORE-004: hud.tscn with virtual joystick (left) + attack button (right), 48dp+ touch targets
- project.godot: input actions `move_left`, `move_right`, `move_forward`, `move_backward`, `attack`
- UI-001: title_screen.gd — Start Game button calls `change_scene_to_file("res://scenes/arena/arena.tscn")`

**Visible Gameplay State/Feedback — Evidence:**
- CORE-005: player.take_damage() + hit signal + PlayerHitFlash/MobHitFlash scale tween on enemy death
- CORE-002: HealthComponent with died signal chain; ContactDamageArea on horse_base
- CORE-005: player health → 0 triggers queue_free()
- CORE-003: alive_enemies counter decrements on HorseBase.died; wave_cleared when all dead

**Brief-Specific Progression/Content Surfaces — Evidence:**
- Wave 1→5 progressive difficulty table in CORE-003
- Score increments on enemy death (CORE-005 damage signal wiring)
- Wave counter increments after wave_cleared (CORE-003 state machine)
- HUD: health_display, wave_display, score_display, enemy_count (CORE-004)
- UI-002: game_over_screen shows final_score + wave_reached + victory/defeat + Play Again + Main Menu buttons

### AC-3: Gameplay finish proof demonstrates the current build's core loop starts, one primary progression path advances, a fail-state or critical end-state is reachable, and any player-facing state reporting required by the shipped UI is exercised with current evidence.

**Core Loop Start:**
- Title screen → Start Game → arena.tscn loads → WaveSpawner in IDLE state → `_start_wave()` → enemies spawn at arena edge → player moves via virtual joystick, attacks via attack button

**Primary Progression Path:**
- Wave 1 (2 horses) → Wave 2 (3) → Wave 3 (4 + black) → Wave 4 (5 + war) → Wave 5 (6 + boss) → all_waves_complete

**Fail-State Reachability:**
- Player health (max 100) decremented on enemy contact via ContactDamageArea (CORE-005)
- Player queue_free() when health ≤ 0 → game_over_screen with victory=false (UI-002)
- Player can die mid-wave — fail-state is reachable

**Critical End-State Reachability:**
- Victory path: all 5 waves cleared → all_waves_complete → game_over_screen with victory=true
- Defeat path: player health → 0 → queue_free() → game_over_screen with victory=false

**Player-Facing State Reporting:**
- HUD health bar (health_display)
- HUD wave number (wave_display)
- HUD score counter (score_display)
- HUD enemy count (enemy_count)
- Game over screen: final score + wave reached + victory/defeat text + buttons

### AC-4: godot4 --headless --path . --quit succeeds so finish validation is based on a loadable product, not just exported artifacts.

**CRITICAL REQUIREMENT — main_scene must be set:**
- FINISH-VALIDATE-001 must verify or set `project.godot` `run/main_scene` to a scene that exists
- UI-001 updated `run/main_scene` to `title_screen.tscn` (confirmed in UI-001 implementation artifact)
- Canonical command: `godot4 --headless --path /home/rowan/womanvshorseVC --quit`
- AC-4 evidence: Must be captured as live execution during FINISH-VALIDATE-001 implementation

**Pre-check:** Before running godot --quit, verify main_scene is set:
```
grep "main_scene" project.godot
```
Expected: `main_scene="res://scenes/ui/title_screen.tscn"`

**If main_scene is empty or points to a missing file:** This is a **blocker** for AC-4. The godot --quit command will exit with code 1 and the validation will fail. In that case, FINISH-VALIDATE-001 implementation must set main_scene to a valid scene before proceeding.

### AC-5: All finish-direction, visual, audio, or content ownership tickets required by the contract are completed before closeout.

**VISUAL-001 (done/reverified):**
- Visual finish target met: player ModelContainer+MeshInstance3D wired to woman-warrior.glb via GLTFDocument
- Zero placeholder meshes in user-facing scenes (grep: CapsuleMesh/BoxMesh/CylinderMesh = 0 matches in user-facing scenes)
- All 6 GLBs present and wired
- Godot headless EXIT:0

**AUDIO-001 (done/trusted):**
- Audio finish target met: AudioManager singleton with 5 procedural SFX (attack/hurt/death/victory/defeat)
- All 4 required touchpoints wired: attack (attack_system.gd hit signal), player hurt (player_controller.gd take_damage), enemy death (horse_base.gd died), game over/victory (game_over_screen.gd)
- Zero external audio files (procedural AudioStreamGenerator only)
- Godot headless EXIT:0

**All MODEL-* tickets (done/reverified or done/trusted):**
- MODEL-001 through MODEL-006 all done with GODOT-certified GLBs
- PROVENANCE.md entries confirmed

**Follow-ups NOT required for closeout:**
- MODEL-007, MODEL-008, FENCE-001 are VISUAL-001 follow-ups tracked as `follow_up_ticket_ids`. They are NOT `depends_on` and do not block FINISH-VALIDATE-001 closeout.

---

## 4. Implementation Steps (Evidence Compilation)

### Step 1: Verify main_scene is set (AC-4 gate)
- Read `project.godot` and confirm `run/main_scene` points to an existing scene file
- If empty or missing: set `run/main_scene="res://scenes/ui/title_screen.tscn"` (confirmed present by UI-001)
- This is a **required pre-check** before godot --quit can succeed

### Step 2: Run godot4 --headless --quit (AC-4 live evidence)
- Execute: `godot4 --headless --path /home/rowan/womanvshorseVC --quit`
- Record exit code as canonical AC-4 evidence

### Step 3: Compile AC-1 APK evidence
- Confirm `build/android/womanvshorseVC-debug.apk` exists (29,824,304 bytes)
- Confirm APK structure: `unzip -l build/android/womanvshorseVC-debug.apk | grep -E "AndroidManifest|classes.dex|libs/"`
- Confirm package name in APK or export_presets.cfg: `com.wvh.vc`
- Confirm 6 GLB files in `assets/models/` via `ls -la assets/models/`
- Confirm each MODEL-* ticket has GODOT-certified evidence

### Step 4: Compile AC-2 user-observable interaction evidence
- Confirm title_screen → arena.tscn scene transition in title_screen.gd
- Confirm input actions in project.godot (move_left, move_right, move_forward, move_backward, attack)
- Confirm virtual joystick + attack button in hud.tscn
- Confirm HUD nodes (health_display, wave_display, score_display, enemy_count) in CORE-004 implementation
- Confirm signal wiring for hit (attack), died (enemies), take_damage (player)

### Step 5: Compile AC-3 gameplay core loop evidence
- Confirm wave_spawner.gd has 5-wave configs with progressive difficulty
- Confirm WaveSpawner state machine: IDLE → spawning → wave_cleared → all_waves_complete
- Confirm player death path: ContactDamageArea → take_damage → health ≤ 0 → queue_free() → game_over_screen
- Confirm victory path: wave 5 cleared → all_waves_complete → game_over_screen(victory=true)
- Confirm HUD updates wired to gameplay state changes

### Step 6: Audit AC-5 ticket completion
- Confirm VISUAL-001 done/reverified (woman-warrior.glb wired, zero placeholder meshes)
- Confirm AUDIO-001 done/trusted (AudioManager with 5 procedural SFX, all touchpoints wired)
- Confirm MODEL-001 through MODEL-006 all done with valid GLBs
- Confirm no pending finish-direction ticket is blocked or open

### Step 7: Produce finish proof artifact
- Write finish proof artifact summarizing all 5 AC mappings to current evidence
- Flag any AC that cannot be fully satisfied headlessly (APK runtime, touch, audio playback)
- Note physical device testing as required post-closeout action

---

## 5. Validation Plan

| AC | Verification Method | Pass Condition |
|----|---------------------|---------------|
| AC-1 | APK file + APK structure check + GLB inventory + wave_spawner godot validation | APK at build/android/womanvshorseVC-debug.apk, valid manifest+dex+libs, 6 GLBs present, 5-wave config in wave_spawner.gd |
| AC-2 | Scene grep + signal wiring grep + HUD node audit + godot headless | title_screen→arena transition, all input actions, HUD nodes, godot EXIT:0 |
| AC-3 | Godot headless load + signal chain grep + wave_spawner state machine review | IDLE→spawning→wave_cleared→all_waves_complete chain, player death→game_over path |
| AC-4 | `godot4 --headless --path /home/rowan/womanvshorseVC --quit` + main_scene pre-check | EXIT:0 with main_scene set; blocker logged if main_scene missing |
| AC-5 | Ticket status audit via manifest.json | VISUAL-001, AUDIO-001, MODEL-001–006 all done/reverified or done/trusted |

---

## 6. Risks and Assumptions

### Cannot Be Proven Headlessly (Required Post-Closeout)

1. **APK runtime on Android device**: Headless validation proves APK structure is valid (manifest, dex, libs), but actual Dalvik/ART execution on hardware requires physical device testing.
2. **Touch input responsiveness**: Virtual joystick and attack button touch event handling cannot be validated headlessly. Physical device testing with actual touch input required.
3. **Gameplay loop timing**: NavigationAgent3D pathfinding recalculation, enemy AI decision cycles, and wave transition timing require device testing.
4. **Audio playback**: Procedural AudioStreamGenerator output cannot be confirmed audible headlessly without audio hardware. AUDIO-001's godot --quit confirms the audio code initializes, not that it sounds correct.

### Assumptions

1. The debug keystore at `/home/rowan/.android/debug.keystore` is valid for APK signing (ANDROID-001 QA verified)
2. The Godot Android export template is correctly installed (implied by ANDROID-001 APK structure validity)
3. GLTFDocument runtime GLB loading works at runtime as it does in editor (CORE-006 design + VISUAL-001 wiring confirmed)
4. main_scene is set to title_screen.tscn (UI-001 updated this; must be verified during AC-4 execution)

### Risk Register

| Risk | Severity | Mitigation |
|------|----------|------------|
| APK installs but crashes on device | Low | Headless cannot detect; physical device testing required |
| Touch controls unresponsive on device | Low | CORE-004 design confirmed; physical device testing required |
| Audio crackling/distortion on device | Low | Procedural synthesis is deterministic; physical device testing required |
| main_scene not set → godot --quit fails | Medium | Pre-check main_scene in Step 1; set if missing before AC-4 run |
| APK too large for target device | Low | 29.8MB debug APK; release build will be smaller |

---

## 7. Blockers or Required User Decisions

### Pre-Closeout Gate (Must Resolve Before Closeout)

1. **AC-4 godot --quit must succeed**: If `main_scene` is not set in project.godot, FINISH-VALIDATE-001 implementation must set it to `res://scenes/ui/title_screen.tscn` before running godot --quit. This is a code change, not a ticket blocker — it is part of the implementation steps.

### Post-Closeout Advisory (Required Before Ship)

1. **Physical Android device testing** is required to confirm APK actually runs on hardware
2. **Touch input testing** on a physical Android device to confirm virtual joystick and attack button responsiveness
3. **Audio output testing** with headphones or speakers to confirm procedural SFX are audible and sound correct

### Closeout Gate Summary

| AC | Status | Evidence Available |
|----|--------|-------------------|
| AC-1 | SATISFIABLE (headless) | APK + GLB + wave configs verified via ANDROID-001 and MODEL-* artifacts |
| AC-2 | SATISFIABLE (headless) | Scene/signal wiring verified via CORE-* and UI-* artifacts |
| AC-3 | SATISFIABLE (headless) | Core loop + progression + fail-state design verified via CORE-* artifacts |
| AC-4 | REQUIRES LIVE EXECUTION | Must run godot4 --quit command; main_scene pre-check required |
| AC-5 | SATISFIABLE | All dependency tickets done/reverified or done/trusted |

**Recommendation**: FINISH-VALIDATE-001 can advance from plan_review. AC-1 through AC-3 and AC-5 are satisfiable from existing artifacts. AC-4 requires a live godot headless execution as the final evidence during implementation. Closeout must note that APK runtime validation requires physical device testing.
