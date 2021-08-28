extends Node

export var gravity = 800
export var grav_incr_treshold = 150
export var grav_incr_amount = 1.4

func _process(delta):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("1"):
		OS.set_window_size(Vector2(
			ProjectSettings.get_setting("display/window/size/width"),
			ProjectSettings.get_setting("display/window/size/height")))
	if Input.is_action_just_pressed("2"):
		OS.set_window_size(Vector2(
			ProjectSettings.get_setting("display/window/size/width") * 2,
			ProjectSettings.get_setting("display/window/size/height") * 2)) 
	if Input.is_action_just_pressed("3"):
		OS.set_window_size(Vector2(
			ProjectSettings.get_setting("display/window/size/width") * 3,
			ProjectSettings.get_setting("display/window/size/height") * 3)) 
	
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://src/levels/MainMenu.tscn")
	
