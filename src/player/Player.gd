extends KinematicBody2D

onready var glob = $"/root/GlobalSettings"

export var speed = 120
export var jump_force = 250
export var jump_limiter = 0.4 # release jump key to go to force * limiter speed.
export var jump_gravity_reduct = 0.3 # reduction of gravity during jump up.
export var early_jump_time = 3 # amount of frames you can press jump before floor.

var velocity = Vector2.ZERO
var earlyJump = 0

var wasOnFloor = false

onready var animated_sprite = $AnimatedSprite


func _physics_process(delta):
#
#	# get left right input. 1 is right, -1 is left
#	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
#
#	#left right motion
#	motion.x = x_input * speed
#
#	if x_input != 0:
#		# true when -1 when left.
#		animatedSprite.flip_h = x_input < 0
#		animatedSprite.play("run")
#	else:
#		animatedSprite.play("idle")
#
#	motion.y += glob.gravity * delta
#
#	var snapVector = Vector2.ZERO
#
#
#	#wasOnFloor is the state of the previous frame.
#	if wasOnFloor:
#		if Input.is_action_just_pressed("move_jump") or earlyJump > 0:
#			motion.y = -jump_force
#		else:
#			snapVector = Vector2.DOWN * 10
#	else:
#		animatedSprite.play("jump")
#		if Input.is_action_pressed("move_jump") and motion.y < -jump_force * jump_limiter:
#			motion.y -= glob.gravity * delta * jump_gravity_reduct
#
#		if Input.is_action_just_released("move_jump") and motion.y <  -jump_force * jump_limiter:
#			motion.y =  -jump_force * jump_limiter
#
#		if Input.is_action_just_pressed("move_jump"):
#			earlyJump = early_jump_time
#
#	if is_on_floor():
#		wasOnFloor = true
#	else:
#		wasOnFloor = false
#
#	if earlyJump > 0:
#		earlyJump -= 1
#
#
#	motion = move_and_slide_with_snap(motion, snapVector, Vector2.UP, true)
	
	
#	FPS:
#	print(Engine.get_frames_per_second())
	pass
	
func get_input_direction():
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if x_input != 0:
		# true when -1 when left.
		animated_sprite.flip_h = x_input < 0
	return x_input
	
	
