class_name ItemGainsModificationEffect
extends Effect

export(String) var item_displayed = ""
export(Array, Resource) var items_modified


static func get_id() -> String:
	return "item_gains_modifications"


func apply(player_index: int) -> void:
	var items = RunData.get_player_items(player_index)
	for item in items_modified:
		#var element = ItemService.get_element(ItemService.items, item)
		RunData.add_item(item, player_index)


func unapply(player_index: int) -> void:
	var items = RunData.get_player_items(player_index)
	for item in items_modified:
		#var element = ItemService.get_element(ItemService.items, item)
		RunData.remove_item(item, player_index)


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
