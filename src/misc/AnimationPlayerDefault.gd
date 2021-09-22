extends AnimationPlayer


export var animation = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	play(animation)
	print(current_animation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
