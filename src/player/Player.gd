extends "res://src/misc/flipping/FlippableKinematic2D.gd"

export var max_speed = 180
export var acceleration = 300
export var slowdown_rate_default = 0.08
var slowdown_rate = slowdown_rate_default
export var jump_force = 250
export var jump_limiter = 0.4 # release jump key to go to force * limiter speed.
export var jump_gravity_reduct = 0.3 # reduction of gravity during jump up.
export var inertia = 40 #originally 5

export var crawl_max_speed = 60
export var crawl_accelration = 200
export var slide_slowdown_rate = 0.005

var velocity = Vector2.ZERO

var wasOnFloor = false

onready var animation_player = $AnimationPlayer
onready var early_jump_timer = $EarlyJumpTimer
onready var wall_jump_ray_front = $WallJumpRayFront
onready var wall_jump_ray_back = $WallJumpRayBack
onready var ice_ray_down = $IceRayDown
onready var wall_jump_block_ray = $WallJumpBlockRay
onready var just_wall_jumped_left_timer = $JustWallJumpedLeftTimer
onready var just_wall_jumped_right_timer = $JustWallJumpedRightTimer
onready var disable_x_input_timer = $DisableXinputTimer
onready var sound_jump = $Audio/SoundJump

func _process(delta):
	if Input.is_action_just_pressed("move_jump"):
		early_jump_timer.start()
	if Input.is_action_just_released("move_jump"):
		early_jump_timer.stop()
		
	# are we on ice?
	if ice_ray_down.is_colliding():
		slowdown_rate = slowdown_rate_default / 4
	else:
		slowdown_rate = slowdown_rate_default

	
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
	if not disable_x_input_timer.time_left > 0:
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

func update_slide_velocity_x(dt):
	# single speed
#	velocity.x = max_speed * get_input_direction()
	var movement_updated = false
	# accelerating:
	if get_input_direction() != 0:
		#moving the direction the player wants to go
		if sign(velocity.x) == get_input_direction() && abs(velocity.x) < crawl_max_speed:
			velocity.x += crawl_accelration * get_input_direction() * dt
			movement_updated = true
			
		elif sign(velocity.x) != get_input_direction():
			#brake faster
			velocity.x = lerp(velocity.x, 0, slowdown_rate)
			if abs(velocity.x) < 30:
				velocity.x = 0 
			velocity.x += crawl_accelration * get_input_direction() * dt
			movement_updated = true
		
		if velocity.x > max_speed:
			velocity.x = max_speed
		elif velocity.x < -max_speed:
			velocity.x = -max_speed
	if not movement_updated:
		var modified_slowdown_rate = slide_slowdown_rate
		if velocity.y > 30:
			modified_slowdown_rate /= 4
		if velocity.y < 30:
			modified_slowdown_rate *= 4
		
		velocity.x = lerp(velocity.x, 0, modified_slowdown_rate)
		if abs(velocity.x) < 30:
			velocity.x = 0 
	pass
