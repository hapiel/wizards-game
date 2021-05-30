extends Area2D

export var direction = Vector2.RIGHT
export var speed = 400

var velocity = Vector2.ZERO

# set settings
func init(dir = direction, spd = speed):
	velocity = dir.normalized() * spd
	

# move
func _process(delta):
	position = position + velocity * delta
	pass

# on hit, destroy
func _on_Projectile_body_entered(body):
	queue_free()

