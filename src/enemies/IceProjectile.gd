extends Area2D

export var direction = Vector2.RIGHT
export var speed = 400

var velocity = Vector2.ZERO

const IceCube = preload("res://src/object/IceCube.tscn")

# set settings
func init(dir = direction, spd = speed):
	velocity = dir.normalized() * spd

func body_entered (body):
	print("TEST")

# move
func _process(delta):
	
	$RayCast2D.set_cast_to(position + velocity)
	$RayCast2D.force_raycast_update()
	
	if $RayCast2D.is_colliding( ):
		var col_point = $RayCast2D.get_collision_point ( )
		if abs((col_point - position).length()) < (velocity*delta).length():
			print("Interrupting due to collisions")
			position = col_point
		else:
			position += velocity*delta
	else:
		position += velocity*delta


func _on_IceProjectile_body_entered(body):
	if body.is_in_group("player"):
		print("Player hit")
	if body.get_groups().has("waterfall"):
		var ice_cube = IceCube.instance()
		ice_cube.position = position
		ice_cube.apply_central_impulse(velocity * 0.2)
		get_tree().current_scene.add_child(ice_cube)
	queue_free()
