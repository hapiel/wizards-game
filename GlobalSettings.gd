extends Node

export var gravity = 800
export var grav_incr_treshold = 150
export var grav_incr_amount = 1.4

func _process(delta):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
