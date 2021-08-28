extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal timer_update(time_string)

var start_time = 0
var final_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	emit_signal("timer_update", get_pretty_time())
	

func _on_StartDetector_body_entered(body):
	if body.is_in_group("player"):
		start_time = OS.get_ticks_msec()
		get_node("../AudioStart").play()
		remove_child($StartDetector)


func _on_EndDetector_body_entered(body):
	if body.is_in_group("player"):
		final_time = OS.get_ticks_msec() - start_time
		get_node("../AudioStop").play()
		remove_child($EndDetector)


func get_current_time():
	if start_time == 0:
		return 0
	if final_time != 0:
		return final_time
	return OS.get_ticks_msec() - start_time
	

func get_pretty_time():
	var time = get_current_time()
	var dec = str((time % 1000) / 10)
	while len(dec) < 2:
		dec += "0"
	return str(time/1000) + "." + dec
