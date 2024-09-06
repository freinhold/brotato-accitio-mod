extends "res://singletons/player_run_data.gd"

#workaround
static func init_stats(all_null_values:bool = false)->Dictionary:
	if Utils == null:
		return {}
	return .init_stats(all_null_values)

static func init_effects()->Dictionary:	
	var effects = .init_effects()
	effects.merge(_accitio_custom_effects())
	return effects

static func _accitio_custom_effects()->Dictionary:
	return {
		"trigger_shield_on_interval": ShieldConfiguration, # interval
		"items_on_level_up": {}, # dictionary (item, amount)	
		"prioritized_items": {}, # dictionary (item, amount)	
	}
