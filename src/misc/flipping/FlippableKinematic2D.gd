# based on
# https://gist.github.com/ultimateprogramer/0a73e6e4b14cdd31898b873358ac4137
# which is based on
# https://github.com/DanielKinsman/godot-tricks

extends KinematicBody2D

const FLIP_HELPER = preload("res://src/misc/flipping/FlipHelper.gd")
var flip_helper

var flip_h = false
var flip_v = false

func _ready():
  flip_helper = FLIP_HELPER.new(self)


# Invoking
func set_flip_h(enable):
		flip_h = enable
		flip_helper.set_flip_h(enable)
		

func set_flip_v(enable):
		flip_v = enable
		flip_helper.set_flip_v(enable)

func get_flip_h():
	return flip_h
	
func get_flip_v():
	return flip_v
