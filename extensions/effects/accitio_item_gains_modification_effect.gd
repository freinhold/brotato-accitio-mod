class_name ItemGainsModificationEffect
extends Effect

export(String) var item_displayed = ""
export(Array, String) var items_modified


static func get_id() -> String:
	return "item_gains_modifications"


func apply(player_index: int) -> void:
	var effects = RunData.get_player_effects(player_index)
	var items = effects["items_on_level_up"]
	for item in items_modified:
		if items.has(item):
			effects["items_on_level_up"][item] += value
		else:
			effects["items_on_level_up"][item] = value
	


func unapply(player_index: int) -> void:
	var effects = RunData.get_player_effects(player_index)
	for item in items_modified:		
		effects["items_on_level_up"][item] -= value

func get_args(_player_index: int) -> Array:
	return [tr(item_displayed.to_upper()), str(abs(value))]


func serialize() -> Dictionary:
	var serialized = .serialize()

	serialized.item_displayed = item_displayed
	serialized.items_modified = items_modified

	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void:
	.deserialize_and_merge(serialized)

	item_displayed = serialized.item_displayed
	items_modified = serialized.items_modified
