extends Camera2D

export var look_ahead_factor = 0.2

# look ahead shift in direction
const SHIFT_TRANS = Tween.TRANS_SINE
const SHIFT_EASE = Tween.EASE_OUT
export var shift_duration = 1.2
export var camera_deadzone = 48


var facing = 0
var old_player_position_x = 0
var should_tween = false

onready var prev_camera_pos = get_camera_position()
onready var tween = $ShiftTween
onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	# adjust limits based on tilemaps in scene
	auto_set_limits()

func _physics_process(delta):
	# update camera offset to always look ahead
	check_facing()
	prev_camera_pos = get_camera_position()
	

func check_facing():
	var new_facing = sign(player.velocity.x)
	if new_facing != 0 && facing != new_facing:
		old_player_position_x = player.position.x
		should_tween = true
		facing = new_facing
		tween.stop(self)
	if should_tween && abs(old_player_position_x - player.position.x) > camera_deadzone:
		should_tween = false
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
	

