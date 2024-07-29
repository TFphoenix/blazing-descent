extends Node2D
class_name GameManager

# IMPORTANT: Main menu should also be levels[0]
@export var levels: Array[PackedScene]

var current_level = 0
var current_scene: Node
var hud: Node
var level_manager: Node

var time = 0.0
var game_has_started = false


func _ready():
	main_menu()


func _process(delta):
	if game_has_started:
		time += delta
		if hud: hud.update_timer(time)


func _on_start_game():
	game_has_started = true
	next_level()


func main_menu():
	game_has_started = false
	time = 0.0
	
	if current_scene: current_scene.queue_free()
	current_level = 0
	current_scene = levels[current_level].instantiate()
	add_child(current_scene)
	current_scene.start_game.connect(_on_start_game)


func next_level():
	if current_level == levels.size() - 1:
		final_level()
		return
	
	current_scene.queue_free()
	current_level += 1
	current_scene = levels[current_level].instantiate()
	add_child(current_scene)
	
	hud = current_scene.get_node("HUD")
	if hud: hud.update_level(current_level)
	
	level_manager = current_scene.get_node("LevelManager")
	if level_manager:
		level_manager.end_run.connect(_on_end_run)
		level_manager.next_level.connect(_on_next_level)
		level_manager.level_idx = current_level


func final_level():
	main_menu()
	# TODO: ...


func _on_end_run():
	main_menu()


func _on_next_level():
	next_level()
