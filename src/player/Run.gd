# Run.gd
extends State

onready var glob = $"/root/GlobalSettings"

func enter(_msg := {}):
	owner.animated_sprite.play("run")
	
	# show landing sprite
	if _msg.has("landing"):
		owner.animated_sprite.set_frame(1)

func physics_update(delta: float) -> void:

	if not owner.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	var input_direction_x = owner.get_input_direction()
	owner.velocity.x = owner.speed * input_direction_x
	owner.velocity.y += glob.gravity * delta
	owner.velocity = owner.move_and_slide_with_snap(owner.velocity, Vector2(0, 10), Vector2.UP, true)


	if Input.is_action_just_pressed("move_jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
