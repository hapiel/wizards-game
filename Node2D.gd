tool
extends Node2D

var x1; var y1; var x2; var y2
var cr; var cg; var cb
var FG:Color=Color8(255,255,255)

func _process(delta):
	update()


func _draw():
		# X and Y
	x1=0
	y1=0
#	x2 = 10
#	y2 = 20
	x2=get_viewport().get_mouse_position().x
	y2=get_viewport().get_mouse_position().y
	
	# Const Color
	draw_line(Vector2(x1,y1), Vector2(x2, y2), FG, 1)
		
	
