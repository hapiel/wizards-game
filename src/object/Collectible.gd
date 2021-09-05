extends Area2D

#onready var collectibles_display = get_tree().get_node("CollectiblesDisplay")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_CollectiblePineapple_body_entered(body):
	if body.is_in_group("player"):
		get_node("AudioCollected").play()
		$Sprite.visible = false
		$CollisionShape2D.disabled = true


func _on_AudioCollected_finished():
	queue_free()
