extends State

onready var ray_cast = $DuckRayCast2D

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
#	owner.velocity = Vector2.ZERO
	ray_cast.set_cast_to(Vector2(0, -10))
	owner.animation_player.play("duck")


func physics_update(delta: float) -> void:
	
	# owner.update_velocity_x(delta)
	
	# only update position if moving, otherwise some glitch happens.
	if abs(owner.velocity.x) > 1:
		owner.velocity = owner.move_and_slide_with_snap(
			owner.velocity, Vector2(0,10), Vector2.UP, true, 4, 0.785398, false)
	
	
	if not owner.is_on_floor():
		state_machine.transition_to("Air")
		return
	else:
		# move with moving blocks
		if owner.get_floor_velocity() != Vector2.ZERO:
			owner.velocity = owner.move_and_slide_with_snap(
				owner.get_floor_velocity() * delta, Vector2(0, 10), Vector2.UP, true, 4,  0.785398, false)	



	if Input.is_action_just_released("move_down"):
		print(ray_cast.is_colliding())
		if not ray_cast.is_colliding():
			state_machine.transition_to("Idle")
