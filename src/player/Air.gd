extends State

onready var glob = $"/root/GlobalSettings"

# If we get a message asking us to jump, we jump.
func enter(_msg := {}) -> void:
	owner.animated_sprite.play("jump")
	if _msg.has("do_jump"):
		owner.velocity.y = -owner.jump_force


func physics_update(delta: float) -> void:
	
	# Horizontal movement.
	owner.velocity.x = owner.speed * owner.get_input_direction()

	# Vertical movement.
	# go up longer when holding jump
	if Input.is_action_pressed("move_jump") and owner.velocity.y < -owner.jump_force * owner.jump_limiter:
		owner.velocity.y -= glob.gravity * delta * owner.jump_gravity_reduct
	# go up less when releasing jump
	if Input.is_action_just_released("move_jump") and owner.velocity.y <  -owner.jump_force * owner.jump_limiter:
		owner.velocity.y =  -owner.jump_force * owner.jump_limiter
	
	if owner.velocity.y > 150:
		owner.velocity.y += glob.gravity * delta * 1.4
	else:
		owner.velocity.y += glob.gravity * delta 
	
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)

	# Landing.
	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition_to("Idle", {landing = true})
		else:
			state_machine.transition_to("Run", {landing = true})
