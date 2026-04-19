# Planning Artifact: AUDIO-001

**Ticket:** AUDIO-001 — Own ship-ready audio finish  
**Lane:** finish-audio  
**Wave:** 13  
**Stage:** planning  
**Dependency:** SETUP-001 (done/trusted)

---

## 1. Scope

Deliver minimal SFX using Godot 4 procedural audio (no external audio files). Wire audio feedback into user-facing gameplay surfaces: player attack, player damage, enemy death, game-over/victory. Eliminate all silent gaps in user-facing interaction.

**Out of scope:** Full audio library, music tracks, streamed audio files, ambient soundscapes.

---

## 2. Audio Touchpoint Audit

| Touchpoint | Source | Signal/Method | Expected Sound |
|---|---|---|---|
| Player attack | `attack_system.gd` | `hit` signal → audio play | Whoosh / swing tone |
| Player takes damage | `player_controller.gd` | `take_damage` → audio play | Hurt tone |
| Enemy death | `horse_base.gd` | `died` signal → audio play | Short impact |
| Wave started | `wave_spawner.gd` | `wave_started` signal | (optional — skip for minimal) |
| Game over | `game_over_screen.gd` | scene shown → jingle | Defeat tone |
| Victory | `game_over_screen.gd` | victory=true → jingle | Victory tone |

**Current state:** No AudioStreamPlayer nodes exist in any user-facing scene. All touchpoints are silent.

---

## 3. Procedural SFX Approach

Use Godot 4 `AudioStreamGenerator` + `AudioStreamGeneratorPlayback` for all sounds:

- **Attack whoosh:** Short noise burst (white noise or rapid sweep), ~0.15s
- **Hurt tone:** Low-pitched descending tone, ~0.2s
- **Enemy death:** Sharp impact — brief noise pop, ~0.1s
- **Defeat jingle:** Short descending arpeggio, ~0.5s
- **Victory jingle:** Short ascending arpeggio, ~0.5s

Implementation pattern:
1. Create `scripts/audio/audio_manager.gd` — singleton that holds pre-built `AudioStreamGenerator` streams for each sound type
2. Add `AudioStreamPlayer` children in the player scene (`player.tscn`) that the audio manager drives
3. Wire signals from `attack_system.gd`, `player_controller.gd`, `horse_base.gd`, and `wave_spawner.gd` to call `AudioManager.play_sound(sound_type)`
4. `AudioManager` generates tones/noise procedurally on first request and caches `AudioStreamGenerator` resources

Alternative simpler approach (if singleton is complex):
- Add `AudioStreamPlayer` nodes directly in `player.tscn`, `game_over_screen.tscn`
- Use `AudioStreamGenerator` inline with short sine/tone sequences
- Wire via `_on_attack_hit()`, `_on_player_damaged()`, `_on_enemy_died()` methods

**Decision: Use a lightweight AudioManager singleton with cached procedural streams.** This keeps audio logic centralized and avoids scattering AudioStreamPlayer nodes across scenes.

---

## 4. AC Mapping

| AC | Requirement | Evidence |
|---|---|---|
| AC-1 | Audio finish target met: Minimal SFX from open sources or procedural | `AudioManager` singleton exists with `play_attack()`, `play_hurt()`, `play_death()`, `play_jingle(victory:bool)` methods; all use `AudioStreamGenerator`; no external audio files referenced |
| AC-2 | No placeholder, missing, or temporary user-facing audio | All 6 touchpoints (attack, hurt, death, game over, victory, wave complete) wired to AudioManager calls; no silent gaps in user-facing interaction; grep confirms zero `null` audio streams in user-facing scenes |

---

## 5. Implementation Steps

1. **Create `scripts/audio/audio_manager.gd` singleton**
   - Pre-build 5 `AudioStreamGenerator` streams (attack, hurt, death, defeat_jingle, victory_jingle)
   - Use `AudioStreamGenerator` + `AudioStreamGeneratorPlayback` to fill buffers with sine/noise wave data
   - Provide `play_attack()`, `play_hurt()`, `play_death()`, `play_jingle(victory: bool)` methods
   - Cache streams in dictionary to avoid regenerating each play call

2. **Add AudioManager autoload in `project.godot`**
   - Register `audio_manager.gd` as autoload singleton at path `res://scripts/audio/audio_manager.gd`

3. **Wire player attack sound in `attack_system.gd`**
   - Connect `hit` signal to `AudioManager.play_attack()`
   - Use `_on_AttackArea_body_entered(body)` callback or the existing signal chain

4. **Wire player hurt sound in `player_controller.gd`**
   - In existing `take_damage()` method, add `AudioManager.play_hurt()`

5. **Wire enemy death sound in `horse_base.gd`**
   - In existing `die()` method or `_on_HealthComponent_died()` callback, add `AudioManager.play_death()`

6. **Wire game-over/victory jingle in `game_over_screen.gd`**
   - In `_ready()` or signal callback, call `AudioManager.play_jingle(victory)` based on `victory` export

7. **Validate with Godot headless**
   - `godot4 --headless --path . --quit` must exit code 0
   - All AudioStreamPlayer nodes have non-null stream property

---

## 6. Validation Plan

1. Grep for `AudioStreamGenerator` in `scripts/audio/` — must find audio_manager.gd
2. Grep for `play_attack\|play_hurt\|play_death\|play_jingle` in `attack_system.gd`, `player_controller.gd`, `horse_base.gd`, `game_over_screen.gd` — all 4 must be present
3. Grep for `AudioManager` in `project.godot` autoload — must be registered
4. `godot4 --headless --path . --quit` — EXIT:0
5. Grep for `null` AudioStream in user-facing scenes — zero matches

---

## 7. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| AudioStreamGenerator buffer underrun causes crackling | Low | Low — acceptable for minimal SFX | Use pre-cached streams, adequate buffer size |
| Signal wiring ordering (signal connected after emission) | Medium | Medium — silent attack sound | Connect signals in `_ready()` or `_enter_tree()`, not deferred |
| Autoload order issues (AudioManager used before ready) | Low | Medium | Use `Engine.get_singleton()` pattern or lazy init in AudioManager |
| Godot headless audio backend may not initialize | Low | Low — headless validation is structural only | godot --quit validates scene graph, not audio playback |
| No audio output device on CI/dev machine | Low | Low — procedural generation doesn't require playback device | Validation is code-structural, not functional audio playback |

**Zero blockers.** All dependencies (SETUP-001, CORE-001, CORE-002, CORE-003, CORE-005, UI-002) are done/trusted.

---

## 8. Blockers

None. Bootstrap not required for audio-only work (Godot script validation uses --headless which does not require audio device).

---

## 9. Closeout Gate

Close AUDIO-001 when: planning artifact registered + implementation artifact registered + review APPROVE + QA PASS + smoke-test PASS.