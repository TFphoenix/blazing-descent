extends Node2D
class_name GameManager

# IMPORTANT: Main menu should also be levels[0] and FinishGame levels[size-1]
@export var levels: Array[PackedScene]

# Scene Management
var current_level = 0
var current_scene: Node
var hud: Node
var level_manager: Node

# Game State
var time = 0.0
var game_running = false

# Music
@onready var music_stream = $"../MusicStream"
const MUSIC_MENU = preload("res://assets/music/music_menu.mp3")
const MUSIC_GAME = preload("res://assets/music/music_game.mp3")


func _ready():
	main_menu()


func _process(delta):
	if game_running:
		time += delta
		Static.time = time
		if hud: hud.update_timer(time)


func _on_start_game():
	game_running = true
	next_level()


func main_menu():
	game_running = false
	time = 0.0
	
	if current_scene: current_scene.queue_free()
	current_level = 0
	current_scene = levels[current_level].instantiate()
	add_child(current_scene)
	current_scene.start_game.connect(_on_start_game)
	
	music_stream.stream = MUSIC_MENU
	music_stream.play()


func end_menu():
	game_running = false
	current_scene.main_menu.connect(_on_end_run)
	
	music_stream.stream = MUSIC_MENU
	music_stream.play()


func next_level():
	current_scene.queue_free()
	current_level += 1
	current_scene = levels[current_level].instantiate()
	add_child(current_scene)
	
	# Last level (FinishGame scene)
	if current_level == levels.size() - 1: end_menu()
	
	hud = current_scene.get_node("HUD")
	if hud: hud.update_level(current_level)
	
	level_manager = current_scene.get_node("LevelManager")
	if level_manager:
		level_manager.end_run.connect(_on_end_run)
		level_manager.next_level.connect(_on_next_level)
		level_manager.level_passed.connect(_on_level_passed)
		level_manager.level_idx = current_level
		
	music_stream.stream = MUSIC_GAME
	music_stream.play()


func _on_level_passed():
	music_stream.stop()


func _on_end_run():
	main_menu()


func _on_next_level():
	next_level()
