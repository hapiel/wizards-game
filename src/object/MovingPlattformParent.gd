extends Node2D

var wait_duration = 0.0 # Wait is currently borked
export var move_to = Vector2.UP * 4
export var duration = 3.0

onready var tween = $Tween
onready var platform = $KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	move_to = move_to * 12
	tween.interpolate_property(platform, "position", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, wait_duration)
	tween.interpolate_property(platform, "position", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + wait_duration*2)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
