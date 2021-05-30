extends State


# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	owner.velocity = Vector2.ZERO
	owner.animated_sprite.play("idle")

var test = 0
func update(delta: float) -> void:
	
	
	if not owner.is_on_floor():
		state_machine.transition_to("Air")
		return


	if Input.is_action_just_pressed("move_jump"):
		# As we'll only have one air state for both jump and fall, we use the `msg` dictionary 
		# to tell the next state that we want to jump.
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Run")
