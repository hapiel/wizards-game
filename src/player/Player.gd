extends "res://src/misc/flipping/FlippableKinematic2D.gd"

export var speed = 120
export var jump_force = 250
export var jump_limiter = 0.4 # release jump key to go to force * limiter speed.
export var jump_gravity_reduct = 0.3 # reduction of gravity during jump up.
export var inertia = 5

var velocity = Vector2.ZERO

var wasOnFloor = false

onready var animated_sprite = $AnimatedSprite
onready var early_jump_timer = $EarlyJumpTimer

func _process(delta):
	if Input.is_action_just_pressed("move_jump"):
		early_jump_timer.start()
	if Input.is_action_just_released("move_jump"):
		early_jump_timer.stop()
	
func get_input_direction():
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if x_input != 0:
		# true when -1 when left.
		set_flip_h(x_input < 0)
#		animated_sprite.flip_h = x_input < 0
	return x_input
	
	
