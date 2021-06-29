extends State

onready var glob = $"/root/GlobalSettings"

var prevVelocity

# If we get a message asking us to jump, we jump.
func enter(_msg := {}) -> void:
	owner.animation_player.play("air_up")
	if _msg.has("do_jump"):
		owner.velocity.y = -owner.jump_force


func physics_update(delta: float) -> void:
	
	prevVelocity = owner.velocity
	
	# Horizontal movement.
	owner.velocity.x = owner.speed * owner.get_input_direction()

	# Vertical movement.
	# go up longer when holding jump
	if Input.is_action_pressed("move_jump") and owner.velocity.y < -owner.jump_force * owner.jump_limiter:
		owner.velocity.y -= glob.gravity * delta * owner.jump_gravity_reduct
	# go up less when releasing jump
	if Input.is_action_just_released("move_jump") and owner.velocity.y <  -owner.jump_force * owner.jump_limiter:
		owner.velocity.y =  -owner.jump_force * owner.jump_limiter
	
	# increas fall speed after a while, tip from Celeste makers
	if owner.velocity.y > glob.grav_incr_treshold:
		owner.velocity.y += glob.gravity * delta * glob.grav_incr_amount
	else:
		owner.velocity.y += glob.gravity * delta 
	
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP, true, 4, 0.785398, false)

	# Landing.
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle", {landing = true, velocity = prevVelocity})
		else:
			state_machine.transition_to("Run", {landing = true})
	else:
		#handle animations
		if owner.velocity.y > 250:
			owner.animation_player.play("air_down")
		elif owner.velocity.y < -100:
			owner.animation_player.play("air_up")
		else:	
			if !(owner.animation_player.get_current_animation() == "air_top"):
				owner.animation_player.play("air_top")
