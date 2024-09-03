class_name ExampleTriggerEffectOnInterval
extends Effect

export(Array, Resource) var sub_effects

static func get_id() -> String:
	return "example_trigger_effect_on_interval"


func apply(player_index: int) -> void:
	var effects = RunData.get_player_effect(key, player_index)
	
	ModLoaderLog.info("Applying effect", "ExampleTriggerEffectOnInterval")
	effects.append(self)


func unapply(player_index: int) -> void:
	var effects = RunData.get_player_effect(key, player_index)
	effects.erase(self)


func get_args(_player_index: int) -> Array:
	return [str(value)]


func get_text(player_index: int, colored: bool = true) -> String:
	var text := .get_text(player_index, colored)
	for sub_effect in sub_effects:
		text += " "
		text += sub_effect.get_text(player_index, colored)
	return text


func serialize() -> Dictionary:
	var serialized = .serialize()
	var serialized_sub_effects := []
	for sub_effect in sub_effects:
		serialized_sub_effects.append(sub_effect.serialize())
	serialized.sub_effects = serialized_sub_effects
	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void:
	.deserialize_and_merge(serialized)
	for serialized_sub_effect in serialized.sub_effects:
		var sub_effect := Effect.new()
		sub_effect.deserialize_and_merge(serialized_sub_effect)
		sub_effects.append(sub_effect)
