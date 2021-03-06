extends State

onready var glob = $"/root/GlobalSettings"


var prevVelocity

# If we get a message asking us to jump, we jump.
func enter(_msg := {}) -> void:
	
	if abs(owner.velocity.x) < 240:
		owner.animation_player.play("air_up")
	else:
		owner.animation_player.play("air_up_front")
		
	if _msg.has("do_jump"):
		owner.velocity.y = -owner.jump_force
		owner.sound_jump.play();


func physics_update(delta: float) -> void:
	
	prevVelocity = owner.velocity
	
	# Horizontal movement, a bit slower
	owner.update_velocity_x(delta * 0.8)
	
	
	
	# walljump
	if owner.early_jump_timer.time_left > 0 and check_wall():
		
		# Gives players less controll over walljumps but makes them much mor consistent
		owner.disable_x_input_timer.start()
		
		owner.early_jump_timer.stop()
		owner.velocity.y = -owner.jump_force*0.90
		owner.sound_jump.play();
		if owner.get_flip_h():
			# check_wall will invert the value if you're already in the right direction
			owner.velocity.x = 180 * check_wall()
		else:
			owner.velocity.x = -180 * check_wall()
			
		# flip sprite depending on direction
		# set timers for easier wall jump direction
		if sign(owner.velocity.x) == 1:
			owner.set_flip_h(false)
			owner.just_wall_jumped_left_timer.start()
			owner.just_wall_jumped_right_timer.stop()
		elif sign(owner.velocity.x) == -1:
			owner.set_flip_h(true)
			owner.just_wall_jumped_right_timer.start()
			owner.just_wall_jumped_right_timer.stop()
			
	if owner.just_wall_jumped_left_timer.time_left > 0 and owner.get_input_direction() == 0:
		owner.velocity.x += owner.acceleration * 1 * delta
		
	if owner.just_wall_jumped_right_timer.time_left > 0 and owner.get_input_direction() == 0:
		owner.velocity.x += owner.acceleration * -1 * delta


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
		if check_wall() && owner.velocity.y > -50:
			owner.animation_player.play("wall")
		else:
			if abs(owner.velocity.x) < 240:
				if owner.velocity.y > 250:
					owner.animation_player.play("air_down")
				elif owner.velocity.y < -100:
					owner.animation_player.play("air_up")
				else:	
					owner.sound_jump.stop()
					if !(owner.animation_player.get_current_animation() == "air_top"):
						owner.animation_player.play("air_top")
			else:
				if owner.velocity.y > 250:
					owner.animation_player.play("air_down_front")
				elif owner.velocity.y < -100:
					owner.animation_player.play("air_up_front")
				else:	
					if !(owner.animation_player.get_current_animation() == "air_top_front"):
						owner.animation_player.play("air_top_front")
						

func check_wall():
	if !owner.wall_jump_block_ray.is_colliding():
		if owner.wall_jump_ray_front.is_colliding():
			return 1
		if owner.wall_jump_ray_back.is_colliding():
			return -1
		else:
			return 0
	
