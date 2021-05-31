# Run.gd
extends State

onready var glob = $"/root/GlobalSettings"

export (NodePath) onready var early_jump_timer = get_node(early_jump_timer)
export(NodePath) onready var landing_timer = get_node(landing_timer)

func enter(_msg := {}):
	owner.animated_sprite.play("run")
	
	# show landing sprite
	if _msg.has("landing"):
		landing_timer.start()
		owner.animated_sprite.set_frame(1)

func physics_update(delta: float) -> void:

	if not owner.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	var input_direction_x = owner.get_input_direction()
	owner.velocity.x = owner.speed * input_direction_x
	owner.velocity.y += glob.gravity * delta
	owner.velocity = owner.move_and_slide_with_snap(owner.velocity, Vector2(0, 10), Vector2.UP, true)


	if early_jump_timer.time_left > 0 && landing_timer.time_left == 0:
		early_jump_timer.stop()
		state_machine.transition_to("Air", {do_jump = true})
		
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
