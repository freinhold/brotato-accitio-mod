class_name ExampleTriggerEffectOnInterval
extends Effect

export(String) var stat = "" 	# stat to scale with
export(float) var scaling = 0.1 	# scaling min_interval - (interval * (1 / scaling * stat)) 
export(int) var min_interval = 1500 	# min loading time

static func get_id() -> String:
	return "trigger_shield_on_interval"


func apply(player_index: int) -> void:
	if (value > -1):
		var effects = RunData.get_player_effects(player_index)
		var config = ShieldConfiguration.new(value, stat, scaling, min_interval)
		effects["trigger_shield_on_interval"] = config 


func unapply(player_index: int) -> void:
	var effects = RunData.get_player_effects(player_index)
	effects["trigger_shield_on_interval"] = null


func get_args(_player_index: int) -> Array:
	return [str(value)]


func serialize() -> Dictionary:
	var serialized = .serialize()	
	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void:
	.deserialize_and_merge(serialized)
