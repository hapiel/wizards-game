extends KinematicBody2D

export var direction = Vector2.RIGHT
export var speed = 400

var velocity = Vector2.ZERO

const IceCube = preload("res://src/object/IceCube.tscn")

# set settings
func init(dir = direction, spd = speed):
	velocity = dir.normalized() * spd
	

# move
func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		if collision.collider.get_groups().has("waterfall"):
			var ice_cube = IceCube.instance()
			ice_cube.position = position
			ice_cube.apply_central_impulse(collision.get_travel() + collision.get_remainder() * 50)
			get_tree().current_scene.add_child(ice_cube)
		
		queue_free()




