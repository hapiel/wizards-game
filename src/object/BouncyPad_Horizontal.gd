extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var push_boost = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SideChecker_body_entered(body):
	if body.is_in_group("player"):
		body.velocity.x += push_boost
		body.get_node("DisableXinputTimer").start()
		$AnimationPlayer.play("Chap_Bounce")
		$Sound.play() 
