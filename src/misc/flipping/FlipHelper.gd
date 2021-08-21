# copied from
# https://gist.github.com/ultimateprogramer/0a73e6e4b14cdd31898b873358ac4137
# which is based on
# https://github.com/DanielKinsman/godot-tricks

extends Object

var flip_h = false
var flip_v = false
var node = null

var actuall_x_scale = 1

func _init(node):
	self.node = node


func get_flip_h():
	return flip_h


func set_flip_h(enable):
	if enable == flip_h:
		return

	flip_h = enable
	h_flip_children()


func get_flip_v():
	return flip_v


func set_flip_v(enable):
	if enable == flip_v:
		return

	flip_v = enable
	v_flip_children()


func h_flip_children():
	var should_flip = false 
	if flip_h:
		if actuall_x_scale == 1:
			should_flip = true
	else:
		if actuall_x_scale == -1:
			should_flip = true
	if should_flip:
		node.scale.x *= -1
		actuall_x_scale *= -1
		for n in node.get_children():
			if n is Camera2D:
				var pos = n.position
				n.translate(Vector2(-2.0 * pos.x, 0.0))
	"""
	for n in node.get_children():
		if not (n is Node2D) or n is Camera2D:
			continue
		
		if n is CollisionShape2D or n is CollisionObject2D:
			n.rotation = -2.0 * n.rotation
		else:
			if flip_h:
				n.scale = Vector2(-1, 1)
			else:
				n.scale = Vector2(1, 1)
			
		var pos = n.position
		n.translate(Vector2(-2.0 * pos.x, 0.0))
"""

func v_flip_children():
	for n in node.get_children():
		if not (n is Node2D):
			continue
		
		if n is CollisionShape2D or n is CollisionObject2D:
			n.rotation = -2.0 * n.rotation
		else:
			if flip_h:
				n.scale = Vector2(1, -1)
			else:
				n.scale = Vector2(1, 1)
			
		var pos = n.position
		n.translate(Vector2(0.0, -2.0 * pos.y))
