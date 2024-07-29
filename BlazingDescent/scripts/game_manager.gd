extends Node2D
class_name GameManager

# IMPORTANT: Main menu should also be levels[0]
@export var levels: Array[PackedScene]

var current_level = 0
var current_scene: Node
var hud: Node

var time = 0.0
var game_has_started = false


func _ready():
	current_scene = levels[current_level].instantiate()
	add_child(current_scene)
	current_scene.start_game.connect(_on_start_game)


func _process(delta):
	if game_has_started:
		time += delta
		if hud: hud.update_timer(time)


func _on_start_game():
	game_has_started = true
	next_level()


func next_level():
	current_scene.queue_free()
	current_level += 1
	current_scene = levels[current_level].instantiate()
	add_child(current_scene)
	
	hud = current_scene.get_node("HUD")
	if hud: hud.update_level(current_level)
	
