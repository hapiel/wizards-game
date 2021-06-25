extends KinematicBody2D


export var max_attack_distance = 200

const Projectile = preload("res://src/enemies/IceProjectile.tscn")

var facing = 1
export var field_of_view_angle = PI/2

#get the center of the player
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var player_collision = player.get_node("CollisionShape2D")

onready var spawn_point = $ProjectileSpawnPoint
onready var ray_cast = $ProjectileSpawnPoint/RayCast2D
onready var state_machine = $WizardStateMachine
onready var projectile_timer = $ProjectileTimer

#
#func _process(delta):

	# this doesn't need to be done every step, could put it on a timer 0.2 seconds? 
	# for performance gain?
	

func ice_spell(direction):
	var projectile = Projectile.instance()
	projectile.init(direction)
	projectile.position = position + spawn_point.position
	get_tree().current_scene.add_child(projectile)


func _on_WizardStateMachine_state_process(state):
	if state == state_machine.State_enum.IDLE:
		
		if _player_in_line_of_sight():
			projectile_timer.start()
			state_machine.transition_to(state_machine.State_enum.ATTACKING)
	
	elif state == state_machine.State_enum.ATTACKING:
		if not _player_in_line_of_sight():
			projectile_timer.stop()
			state_machine.transition_to(state_machine.State_enum.IDLE)
		elif projectile_timer.time_left <= 0:
			ice_spell(player.position - position - spawn_point.position + player_collision.position)
			projectile_timer.start()
			


func _player_in_line_of_sight():
	var player_pos = player.position - position - spawn_point.position + player_collision.position
	
	if player_pos.length() < max_attack_distance:
		if player_pos.angle() > Vector2(facing, 0).angle() - field_of_view_angle/2 \
		&& player_pos.angle() < Vector2(facing, 0).angle() + field_of_view_angle/2:
			ray_cast.cast_to = player_pos
			# without force the effect is delayed for some reason
			ray_cast.force_raycast_update()
			if ray_cast.is_colliding():
				if ray_cast.get_collider() == player:
					return true
	return false

