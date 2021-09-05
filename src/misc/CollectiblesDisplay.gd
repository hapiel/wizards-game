extends CanvasLayer

onready var collectibles_display_text = $CollectiblesDisplayText
var max_collectibles = 0
var collected = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	max_collectibles = len(get_tree().get_nodes_in_group("collectible"))
	collectibles_display_text.bbcode_text = "[right]" + str(collected) + "/" + str(max_collectibles)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	collected = max_collectibles - len(get_tree().get_nodes_in_group("collectible"))
	collectibles_display_text.bbcode_text = "[right]" + str(collected) + "/" + str(max_collectibles)
