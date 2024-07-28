extends Node2D
class_name GameManager

@export var levels: Array[PackedScene]

var current_level = 0
var current_scene: Node
var hud: Node

var time = 0.0


func _ready():
	var current_scene = levels[current_level].instantiate()
	add_child(current_scene)
	hud = current_scene.get_node("HUD")
	hud.update_level(current_level)


func _process(delta):
	time += delta
	hud.update_timer(time)
	
