extends KinematicBody2D

# walking idle hurt nostaff
var state = "walking" 
var direction = 0
export var speedNormal = 60
export var speedDisarmed = 120
export var GRAVITY = 800 # TODO: use singletons for global variables

var motion = Vector2.ZERO

onready var animatedSprite = $AnimatedSprite

func _ready():
	#random direction
	if randf() > 0.5:
		direction = -1
	else:
		direction = 1
	

func _physics_process(delta):
	
	if state == "walking":
		if is_on_wall():
			direction *= -1
		motion.x = direction * speedNormal
		animatedSprite.flip_h = direction < 0

	if state == "hurt":
		motion.x = 0
		if randf() < 0.001:
			state_walking()
		
		
	motion.y += GRAVITY * delta
	
	motion = move_and_slide_with_snap(motion, Vector2.DOWN * 10, Vector2.UP, true)



func _on_TopChecker_body_entered(body):
	state_hurt()
	
	
func state_hurt():
	state = "hurt"
	animatedSprite.play("hurt")

func state_walking():
	state = "walking"
	animatedSprite.play("staff")
	
