extends KinematicBody2D

export var max_attack_distance = 200

var facing = 1
export var field_of_view_angle = PI/2

#get the center of the player
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var player_collision = player.get_node("CollisionShape2D")


func _process(delta):
	print()
	# this doesn't need to be done every step, could put it on a timer 0.2 seconds? 
	# for performance gain?
	var player_pos = player.position - position + player_collision.position
	
	if player_pos.length() < max_attack_distance:
		if player_pos.angle() > Vector2(facing, 0).angle() - field_of_view_angle/2 \
		&& player_pos.angle() < Vector2(facing, 0).angle() + field_of_view_angle/2:
			$RayCast2D.cast_to = player_pos
			if $RayCast2D.is_colliding():
				if $RayCast2D.get_collider() == player:
					$Line2D.points = PoolVector2Array([Vector2.ZERO, player_pos])

	
	
	
