extends Node2D

const Projectile = preload("res://src/enemies/bullet_hell_test/Projectile_bh.tscn")

export var time = 0.4

onready var projectile_timer = $Timer
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var player_collision = player.get_node("CollisionShape2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = time
	pass # Replace with function body.


func _process(delta):
	if projectile_timer.time_left <= 0:
			bullet(player.position - position + player_collision.position)
			projectile_timer.start()
	
	
func bullet(direction):
	var projectile = Projectile.instance()
	projectile.init(direction)
	projectile.position = position
	print(position)
	get_tree().current_scene.add_child(projectile)
	projectile_timer.start()
