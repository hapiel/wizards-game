extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# this stops the block from ever rotating, together with high angular dampening
	# no longer needed, character mode
	#set_inertia(2000000)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#
#	pass
