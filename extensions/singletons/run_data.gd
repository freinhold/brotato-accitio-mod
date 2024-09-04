extends "res://singletons/run_data.gd"
	


func _ready()->void:
	#RunData.connect("levelled_up", self, "levelup_hook") -- kills game
	_example_effect_keys_full_serialization()

func add_item(item:ItemData, player_index: int)->void:
	.add_item(item, player_index)

func add_weapon(weapon:WeaponData, player_index:int, is_starting:bool = false)->WeaponData:
	var weapon_data = .add_weapon(weapon, is_starting)
	return weapon_data
	
func init_tracked_effects() -> Dictionary:
	var vanilla = .init_tracked_effects()
	var custom_tracker = {
		"character_example1": 0,
	}

	vanilla.merge(custom_tracker)

	return vanilla

func _example_effect_keys_full_serialization()->void:
	# These effects reference Resources and need full serialization
	#effect_keys_full_serialization.push_back("items_on_level_up")
	pass

# LevelUp effects
func level_up(player_index:int)->void:
	#var effects = RunData.get_player_effects(player_index)
	for item in RunData.get_player_effect("items_on_level_up", player_index):
		var data = ItemService.get_element(ItemService.items, item)
		RunData.add_item(data, player_index)
	#var effects = RunData.get_player_effects(player_index)
	#if effects["items_on_level_up"].size() > 0:
	#	for item_id in effects["items_on_level_up"]:
	#		for i in item_id[1]:
	#			var item = ItemService.get_element(ItemService.items, item_id[0])
	#			add_item(item, player_index)

	.level_up(player_index)
