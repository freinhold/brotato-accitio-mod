extends "res://singletons/item_service.gd"


func _get_rand_item_for_wave(wave:int, player_index:int, type:int, args:GetRandItemForWaveArgs)->ItemParentData:
	var prioritized_items = RunData.get_player_effects(player_index)["prioritized_items"]
	
	if prioritized_items != null && prioritized_items.size() > 0 :
		# only present one prioritized item
		var size = prioritized_items.size()
		var item = prioritized_items.keys()[randi() % size]
		var chance = prioritized_items[item] / 100
		
		var spawn_item = randf() < chance
		
		if spawn_item:
			return ItemService.get_element(ItemService.items, item) as ItemData
			
	return ._get_rand_item_for_wave(wave, player_index, type, args)
