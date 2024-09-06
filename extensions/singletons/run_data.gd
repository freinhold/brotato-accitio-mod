extends "res://singletons/run_data.gd"
	


func _ready()->void:
	_example_effect_keys_full_serialization()

func add_item(item:ItemData, player_index: int)->void:
	.add_item(item, player_index)

func add_weapon(weapon:WeaponData, player_index:int, is_starting:bool = false)->WeaponData:
	var weapon_data = .add_weapon(weapon, 0, is_starting)
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
	var effects = RunData.get_player_effects(player_index)["items_on_level_up"]
	
	for key in effects:		
		var data = ItemService.get_element(ItemService.items, key)
		for i in effects[key]:
			RunData.add_item(data, player_index)

	.level_up(player_index)
