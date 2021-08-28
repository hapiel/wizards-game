extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Button_time_trial_pressed():
	get_tree().change_scene("res://src/Levels/timeTrial2.tscn")


func _on_Button_jump_challenge_pressed():
	get_tree().change_scene("res://src/Levels/BouncyCastle.tscn")


func _on_Button_exit_pressed():
	get_tree().quit()
