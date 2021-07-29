extends "res://src/misc/flipping/FlippableKinematic2D.gd"

export var max_speed = 180
export var acceleration = 300
export var slowdown_rate = 0.08
export var jump_force = 250
export var jump_limiter = 0.4 # release jump key to go to force * limiter speed.
export var jump_gravity_reduct = 0.3 # reduction of gravity during jump up.
export var inertia = 40 #originally 5

var velocity = Vector2.ZERO

var wasOnFloor = false

onready var animation_player = $AnimationPlayer
onready var early_jump_timer = $EarlyJumpTimer
onready var wall_jump_ray_front = $WallJumpRayFront
onready var wall_jump_ray_back = $WallJumpRayBack

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
	return x_input
	
	
	
func update_velocity_x(dt):
	# single speed
#	velocity.x = max_speed * get_input_direction()

	# accelerating:
	if get_input_direction() != 0:
		#moving the direction the player wants to go
		if sign(velocity.x) == get_input_direction():
			velocity.x += acceleration * get_input_direction() * dt
		else:
			#brake faster
			velocity.x = lerp(velocity.x, 0, slowdown_rate)
			if abs(velocity.x) < 30:
				velocity.x = 0 
			velocity.x += acceleration * get_input_direction() * dt
		
		if velocity.x > max_speed:
			velocity.x = max_speed
		elif velocity.x < -max_speed:
			velocity.x = -max_speed
	else:
		velocity.x = lerp(velocity.x, 0, slowdown_rate)
		if abs(velocity.x) < 30:
			velocity.x = 0 
		
		
	pass
