extends KinematicBody2D

export var direction = Vector2.RIGHT
export var speed = 400

var velocity = Vector2.ZERO

# set settings
func init(dir = direction, spd = speed):
	velocity = dir.normalized() * spd
	

# move
func _process(delta):
	if move_and_collide(velocity * delta) != null:
		# on hit, destroy
		queue_free()




