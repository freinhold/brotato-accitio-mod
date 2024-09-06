extends "res://ui/hud/ui_progress_bar.gd"

func _ready()->void :

	# Adds green as color for shield effect
	effect_colors["shield"] = Color( 0, 0.5, 0.09, 1 )
	._ready()
