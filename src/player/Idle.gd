extends State

export(NodePath) onready var early_jump_timer = get_node(early_jump_timer)
export(NodePath) onready var landing_timer = get_node(landing_timer)

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	owner.velocity = Vector2.ZERO
	owner.animation_player.play("idle")
	if _msg.has("landing"):
		landing_timer.start()

var test = 0
func physics_update(delta: float) -> void:
	
	if not owner.is_on_floor():
		state_machine.transition_to("Air")
		return
	else:
		# move with moving blocks
		if owner.get_floor_velocity() != Vector2.ZERO:
			owner.velocity = owner.move_and_slide_with_snap(
				owner.get_floor_velocity() * delta, Vector2(0, 10), Vector2.UP, true, 4,  0.785398, false)

	if early_jump_timer.time_left > 0 && landing_timer.time_left == 0:
		early_jump_timer.stop()
		state_machine.transition_to("Air", {do_jump = true})

	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Run")
