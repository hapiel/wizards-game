extends State

onready var glob = $"/root/GlobalSettings"

export (NodePath) onready var early_jump_timer = get_node(early_jump_timer)
export(NodePath) onready var late_jump_timer = get_node(late_jump_timer)
export(NodePath) onready var landing_timer = get_node(landing_timer)

func enter(_msg := {}):
	owner.animation_player.play("sprint")
	
#	# show landing sprite
	if _msg.has("landing"):
		landing_timer.start()


func physics_update(delta: float) -> void:

	# delay the falling
	if not owner.is_on_floor():
		if late_jump_timer.time_left == 0:
			late_jump_timer.start()
	
	var input_direction_x = owner.get_input_direction()
	owner.velocity.x = owner.speed * input_direction_x
	# only apply gravity if not in late_jump substate
	if late_jump_timer.time_left == 0:
		owner.velocity.y += glob.gravity * delta
	owner.velocity = owner.move_and_slide_with_snap(owner.velocity, Vector2(0, 10), Vector2.UP, true, 4,  0.785398, false)
	for index in owner.get_slide_count():
		var collision = owner.get_slide_collision(index)
		if collision.collider.is_in_group("object_bodies"):
			collision.collider.apply_central_impulse(-collision.normal * owner.inertia)
		

	if early_jump_timer.time_left > 0 && landing_timer.time_left == 0:
		early_jump_timer.stop()
		state_machine.transition_to("Air", {do_jump = true})
		
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")


func _on_LateJumpTimer_timeout():
	state_machine.transition_to("Air")


