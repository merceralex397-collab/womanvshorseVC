class_name HorseVariants
extends RefCounted

## Singleton dictionary of enemy variant definitions.
## Each entry maps a variant name (String) to a Dictionary with:
##   model_path:     String   — path to the GLB asset
##   speed:          float    — movement speed
##   max_health:     float    — health pool
##   contact_damage: float    — damage on contact with player
##   score_value:    int      — points awarded on death

const VARIANTS: Dictionary = {
	"brown": {
		"model_path":     "res://assets/models/horse-brown.glb",
		"speed":          2.5,
		"max_health":     80.0,
		"contact_damage": 10.0,
		"score_value":    100,
	},
	"black": {
		"model_path":     "res://assets/models/horse-black.glb",
		"speed":          4.0,
		"max_health":     60.0,
		"contact_damage": 15.0,
		"score_value":    150,
	},
	"war": {
		"model_path":     "res://assets/models/horse-war.glb",
		"speed":          2.0,
		"max_health":     150.0,
		"contact_damage": 25.0,
		"score_value":    250,
	},
	"boss": {
		"model_path":     "res://assets/models/horse-boss.glb",
		"speed":          1.5,
		"max_health":     300.0,
		"contact_damage": 40.0,
		"score_value":    1000,
	},
}

## Returns the variant dictionary for a given variant name, or the brown variant as default.
static func get_variant(variant_name: String) -> Dictionary:
	return VARIANTS.get(variant_name, VARIANTS["brown"])
