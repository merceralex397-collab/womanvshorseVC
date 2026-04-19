## AudioManager — Procedural SFX autoload for Godot 4.6
##
## Uses AudioStreamGenerator + AudioStreamGeneratorPlayback._mix_buffer()
## to fill PCM ring buffers at init time. No external audio files.
##
## Each sound uses a dedicated AudioStreamPlayer from a fixed pool.
## All signals from CORE/CORE-005/UI-002 are wired in the consuming scripts.
##
## Public API:
##   AudioManager.play_attack()
##   AudioManager.play_hurt()
##   AudioManager.play_death()
##   AudioManager.play_victory()
##   AudioManager.play_defeat()
##   AudioManager.play_jingle(victory: bool)
##
## Registered as autoload "AudioManager" in project.godot.

extends Node

## One entry per pooled sound slot.
class SoundPlayer:
	var player: AudioStreamPlayer
	var gen: AudioStreamGenerator
	var name: String
	var samples: PackedVector2Array
	var played: bool = false

var _pool: Array[SoundPlayer] = []

func _ready() -> void:
	# ── attack: white-noise whoosh with fast decay ──────────────────────────
	_pool.append(_make_slot("attack", _build_attack_samples(), 0.13))

	# ── hurt: descending sine sweep, 300→135 Hz ────────────────────────────
	_pool.append(_make_slot("hurt", _build_hurt_samples(), 0.20))

	# ── death: noise+90Hz tone mix, very fast decay ─────────────────────────
	_pool.append(_make_slot("death", _build_death_samples(), 0.15))

	# ── victory: ascending C5-E5-G5-C6 arpeggio ────────────────────────────
	_pool.append(_make_slot("victory", _build_jingle_samples([523.0, 659.0, 784.0, 1047.0], 0.12, 0.45), 0.52))

	# ── defeat: descending G4-E4-C4 arpeggio ────────────────────────────────
	_pool.append(_make_slot("defeat", _build_jingle_samples([392.0, 311.1, 261.6], 0.15, 0.40), 0.50))


## Build a sound slot: one AudioStreamPlayer + one AudioStreamGenerator.
## Fills the generator ring buffer with all samples at construction time.
func _make_slot(name: String, samples: PackedVector2Array, dur: float) -> SoundPlayer:
	var gen := AudioStreamGenerator.new()
	gen.mix_rate = 44100.0
	gen.buffer_length = dur

	var player := AudioStreamPlayer.new()
	player.bus = "Master"
	add_child(player)
	player.stream = gen

	var slot := SoundPlayer.new()
	slot.player = player
	slot.gen = gen
	slot.name = name
	slot.samples = samples
	return slot


## Fill the ring buffer of `gen` with all of `samples`.
## Called once per slot at init; the ring buffer is large enough for the whole sound.
func _fill_buffer(gen: AudioStreamGenerator, samples: PackedVector2Array) -> void:
	var playback: AudioStreamGeneratorPlayback = gen.get_stream_playback()
	playback._mix_buffer(samples)


## ── Sample generators ────────────────────────────────────────────────────────

func _build_attack_samples() -> PackedVector2Array:
	var sr := 44100.0
	var dur := 0.13
	var n := int(dur * sr)
	var buf: PackedVector2Array
	buf.resize(n)
	var rng := RandomNumberGenerator.new()
	for i in n:
		var t := float(i) / sr
		var env := exp(-t * 18.0)                         # fast exponential decay
		var s := (rng.randf() * 2.0 - 1.0) * env * 0.7
		buf[i] = Vector2(s, s)
	return buf


func _build_hurt_samples() -> PackedVector2Array:
	var sr := 44100.0
	var dur := 0.20
	var n := int(dur * sr)
	var buf: PackedVector2Array
	buf.resize(n)
	var base_freq := 300.0
	for i in n:
		var t := float(i) / sr
		var freq := base_freq * (1.0 - t * 0.55)           # 300 → 135 Hz sweep
		var s := sin(2.0 * PI * freq * t) * (1.0 - t) * 0.65
		buf[i] = Vector2(s, s)
	return buf


func _build_death_samples() -> PackedVector2Array:
	var sr := 44100.0
	var dur := 0.15
	var n := int(dur * sr)
	var buf: PackedVector2Array
	buf.resize(n)
	var rng := RandomNumberGenerator.new()
	for i in n:
		var t := float(i) / sr
		var env := exp(-t * 22.0)                          # very fast decay
		var noise := (rng.randf() * 2.0 - 1.0) * env * 0.8
		var tone_val := sin(2.0 * PI * 90.0 * t) * 0.3 * env
		buf[i] = Vector2(noise + tone_val, noise + tone_val)
	return buf


func _build_jingle_samples(freqs: Array, note_dur: float, amplitude: float) -> PackedVector2Array:
	var sr := 22050.0
	var note_samp := int(note_dur * sr)
	var total := freqs.size() * note_samp
	var buf: PackedVector2Array
	buf.resize(total)
	var rng := RandomNumberGenerator.new()
	for ni in freqs.size():
		var freq: float = freqs[ni]
		var note_start: int = ni * note_samp
		for j in note_samp:
			var idx := note_start + j
			if idx >= total:
				break
			var tl := float(j) / sr
			var env := 1.0
			if tl < 0.01:
				env = tl / 0.01
			elif tl > note_dur - 0.05:
				env = (note_dur - tl) / 0.05
			var s_val := sin(2.0 * PI * freq * tl) * amplitude * env
			s_val += (rng.randf() * 2.0 - 1.0) * 0.03 * env
			buf[idx] = Vector2(s_val, s_val)
	return buf


## ── Public play API ───────────────────────────────────────────────────────────

func play_attack() -> void:
	_play("attack")


func play_hurt() -> void:
	_play("hurt")


func play_death() -> void:
	_play("death")


func play_victory() -> void:
	_play("victory")


func play_defeat() -> void:
	_play("defeat")


func play_jingle(is_victory: bool) -> void:
	_play("victory" if is_victory else "defeat")


## Find the named slot, pre-fill its buffer if not done, and play.
func _play(name: String) -> void:
	for slot in _pool:
		if slot.name == name:
			if not slot.played:
				_fill_buffer(slot.gen, slot.samples)
				slot.played = true
			slot.player.play()
			return
	push_warning("AudioManager: unknown sound '" + name + "'")
