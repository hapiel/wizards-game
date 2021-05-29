extends Camera2D

export var look_ahead_factor = 0.2

# look ahead shift in direction
const SHIFT_TRANS = Tween.TRANS_SINE
const SHIFT_EASE = Tween.EASE_OUT
export var shift_duration = 0.8


var facing = 0

onready var prev_camera_pos = get_camera_position()
onready var tween = $ShiftTween
onready var player = get_parent()

func _ready():
	# adjust limits based on tilemaps in scene
	auto_set_limits()

func _physics_process(delta):
	# update camera offset to always look ahead
	check_facing()
	prev_camera_pos = get_camera_position()
	

func check_facing():
	var new_facing = sign(player.motion.x)
	if new_facing != 0 && facing != new_facing:
		facing = new_facing
		var target_offset = get_viewport_rect().size.x * facing * look_ahead_factor
		tween.interpolate_property(self, "position:x", position.x, target_offset, shift_duration, SHIFT_TRANS, SHIFT_EASE)
		tween.start()


func auto_set_limits():
	limit_left = 0
	limit_right = 0
	limit_top = 0
	limit_bottom = 0

	# Find all tilemaps in current scene
	var tilemaps = []
	for child in get_tree().get_current_scene().get_children():
		if child is TileMap:
			tilemaps.append(child)
	
	# Set limits to combined map size
	for tilemap in tilemaps:
		var used = tilemap.get_used_rect()
		var cell_size = tilemap.cell_size
		limit_left = min(used.position.x * cell_size.x, limit_left)
		limit_right = max(used.end.x * cell_size.x, limit_right)
		limit_top = min(used.position.y * cell_size.y, limit_top)
		limit_bottom = max(used.end.y * cell_size.y, limit_bottom)
	

