extends "res://entities/units/player/player.gd"

var _shield: = 0 # maybe switch to bool
var _shield_timer = Timer.new()
var _shield_config = null

func _ready()->void :
	# Get shield and create timer, if activated
	_shield_config = RunData.get_player_effect("trigger_shield_on_interval", player_index)
	
	if _shield_config != null && _shield_config.base_interval > -1:		
		
		# start with shield activated
		_shield = 1
		
		#_shield_timer.timeout.connect(_on_shield_timer_timeout)
		_shield_timer.connect("timeout", self, "_on_shield_timer_timeout")
		_shield_timer.one_shot = true
				
		add_child(_shield_timer)		
		
	._ready()

func _start_timer() -> void:
	var base_interval = _shield_config.base_interval / 1000
	var min_interval = _shield_config.min_interval / 1000
	var player_level = RunData.get_player_level(player_index)
	var scaling = 1
	if player_level > 0:
		scaling = 1 / (player_level * _shield_config.scaling)
	var calculated_interval = min_interval + (base_interval * scaling)
	_shield_timer.start(calculated_interval)

func _on_shield_timer_timeout() -> void:
	if _shield == 0:
		_shield = 1
	#queue_free()
	
func life_bar_effects()->Dictionary:

	# Add shield as lifebar effect
	var life_bar_effects = .life_bar_effects()
	life_bar_effects["shield"] = _shield
	return life_bar_effects

func get_damage_value(dmg_value:int, _from_player_index:int, armor_applied: = true, dodgeable: = true, _is_crit: = false, _hitbox:Hitbox = null)->Unit.GetDamageValueResult:
	var result = .get_damage_value(dmg_value, _from_player_index, armor_applied, dodgeable, _is_crit, _hitbox)
	
	# use shield before using the hit_protection. There replace a protected hit by a shielded hit.
	if (_shield > 0 && result.value > 0):
		if result.protected:
			_hit_protection += 1
		_shield = 0
		result.value = 0
		result.protected = true
		
		# Start regeneration-timer of shield
		_start_timer()
	return result
