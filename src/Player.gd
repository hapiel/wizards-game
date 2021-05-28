extends KinematicBody2D


export var MAX_SPEED = 120
export var GRAVITY = 800
export var JUMP_FORCE = 250
export var JUMP_LIMITER = 0.4 # release jump key to go to force * limiter speed.
export var JUMP_GRAVITY_REDUCT = 0.3 # reduction of gravity during jump up.
export var EARLY_JUMP_TIME = 3 # amount of frames you can press jump before floor.

var motion = Vector2.ZERO
var earlyJump = 0

var wasOnFloor = false

onready var animatedSprite = $AnimatedSprite

func _physics_process(delta):
	
	# get left right input. 1 is right, -1 is left
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	#left right motion
	motion.x = x_input * MAX_SPEED
	
	if x_input != 0:
		# true when -1 when left.
		animatedSprite.flip_h = x_input < 0
		animatedSprite.play("run")
	else:
		animatedSprite.play("idle")
	
	motion.y += GRAVITY * delta
	
	var snapVector = Vector2.ZERO
	
	
	#wasOnFloor is the state of the previous frame.
	if wasOnFloor:
		if Input.is_action_just_pressed("move_jump") or earlyJump > 0:
			motion.y = -JUMP_FORCE
		else:
			snapVector = Vector2.DOWN * 10
	else:
		animatedSprite.play("jump")
		if Input.is_action_pressed("move_jump") and motion.y < -JUMP_FORCE * JUMP_LIMITER:
			motion.y -= GRAVITY * delta * JUMP_GRAVITY_REDUCT
		
		if Input.is_action_just_released("move_jump") and motion.y <  -JUMP_FORCE * JUMP_LIMITER:
			motion.y =  -JUMP_FORCE * JUMP_LIMITER
			
		if Input.is_action_just_pressed("move_jump"):
			earlyJump = EARLY_JUMP_TIME
		
	if is_on_floor():
		wasOnFloor = true
	else:
		wasOnFloor = false
	
	if earlyJump > 0:
		earlyJump -= 1
	
	
	motion = move_and_slide_with_snap(motion, snapVector, Vector2.UP, true)
	
#	FPS:
#	print(Engine.get_frames_per_second())
	
