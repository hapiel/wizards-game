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

#
#func _process(delta):

	# this doesn't need to be done every step, could put it on a timer 0.2 seconds? 
	# for performance gain?
	

func ice_spell(direction):
	var projectile = Projectile.instance()
	projectile.init(direction)
	projectile.position = position + spawn_point.position
	get_tree().current_scene.add_child(projectile)
	

func _on_ProjectileTimer_timeout():
	var player_pos = player.position - position - spawn_point.position + player_collision.position
	
	if player_pos.length() < max_attack_distance:
		if player_pos.angle() > Vector2(facing, 0).angle() - field_of_view_angle/2 \
		&& player_pos.angle() < Vector2(facing, 0).angle() + field_of_view_angle/2:
			ray_cast.cast_to = player_pos
			# without force the effect is delayed for some reason
			ray_cast.force_raycast_update()
			if ray_cast.is_colliding():
				if ray_cast.get_collider() == player:
					# line for easy debugging
					# $Line2D.points = PoolVector2Array([Vector2.ZERO, player_pos])
					ice_spell(player_pos)
