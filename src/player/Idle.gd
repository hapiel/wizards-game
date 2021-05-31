extends State

export (NodePath) onready var early_jump_timer = get_node(early_jump_timer)
export(NodePath) onready var landing_timer = get_node(landing_timer)

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	owner.velocity = Vector2.ZERO
	owner.animated_sprite.play("idle")
	if _msg.has("landing"):
		landing_timer.start()

var test = 0
func update(delta: float) -> void:
	
	if not owner.is_on_floor():
		state_machine.transition_to("Air")
		return

	if early_jump_timer.time_left > 0 && landing_timer.time_left == 0:
		early_jump_timer.stop()
		state_machine.transition_to("Air", {do_jump = true})

	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Run")
