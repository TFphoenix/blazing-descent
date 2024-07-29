extends Node2D
class_name LevelManager

# Scene
@export var hud: Control
@export var background: Node
@export var spawners: Array[Node]

# Signals
signal end_run
signal next_level
signal level_passed

# Level
var level_ended = false
var level_idx = 1:
	set(value):
		level_idx = value
		if background: background.set_planet(value)

# Atmospheres
@export var progress_rate = 0.02
@export var atmospheres = [
	{
		'threshold': 0.0,
		'overheat_rate': 0.01
	}
]
var current_atmosphere = 0
var next_atmosphere = 1

# State
var progress = 0.0:
	set(value):
		progress = clamp(value, 0.0, 1.0)
		if hud: hud.update_progress(progress)
		if progress >= 1: _on_level_passed()
var overheat = 0.0:
	set(value):
		overheat = clamp(value, 0.0, 1.0)
		if hud: hud.update_overheat(overheat)
		if overheat >= 1: _on_level_failed()


# SFX
@onready var sfx_stream_collision = $"../SFXStream_Collision"
@onready var sfx_stream_ship = $"../SFXStream_Ship"
const SFX_ASTEROID = preload("res://assets/sfx/hit_asteroid.wav")
const SFX_BIG_ASTEROID = preload("res://assets/sfx/hit_big_asteroid.wav")
const SFX_LANDING = preload("res://assets/sfx/landing.wav")
const SFX_PICKUP_REPAIR = preload("res://assets/sfx/pickup_repair.wav")
const SFX_PICKUP_SPEED = preload("res://assets/sfx/pickup_speed.wav")
const SFX_FAIL = preload("res://assets/sfx/fail.wav")
const SFX_ENGINE_NORMAL = preload("res://assets/sfx/engine_normal.mp3")


func _ready():
	hud.restart_level.connect(_on_level_restarted)
	hud.next_level.connect(_on_next_level)
	hud.end_run.connect(_on_end_run)
	
	sfx_stream_ship.stream = SFX_ENGINE_NORMAL
	sfx_stream_ship.play()


func _process(delta):
	# Update progress
	progress += progress_rate * delta
	
	# Update overheat
	overheat += atmospheres[current_atmosphere]['overheat_rate'] * delta
	
	# Next atmosphere
	if next_atmosphere < atmospheres.size() and progress >= atmospheres[next_atmosphere]['threshold']:
		current_atmosphere = next_atmosphere
		next_atmosphere += 1


func on_collision(type: Const.CollisionType):
	overheat += Const.OVERHEAT[type]
	hud.update_overheat(overheat)
	
	match type:
		Const.CollisionType.ASTEROID: sfx_stream_collision.stream = SFX_ASTEROID
		Const.CollisionType.REPAIR_KIT: sfx_stream_collision.stream = SFX_PICKUP_REPAIR
		Const.CollisionType.BIG_ASTEROID: sfx_stream_collision.stream = SFX_BIG_ASTEROID
		Const.CollisionType.SPEED_BOOST:
			progress += Const.PROGRESS_SPEED_BOOST
			sfx_stream_collision.stream = SFX_PICKUP_SPEED
	if !level_ended: sfx_stream_collision.play()


func _on_level_passed():
	if level_ended: return
	
	end_level()
	level_passed.emit()
	hud.display_passed()
	
	sfx_stream_ship.stream = SFX_LANDING
	sfx_stream_ship.play()


func _on_level_failed():
	if level_ended: return
	
	end_level()
	hud.display_failed()
	
	sfx_stream_ship.stream = SFX_FAIL
	sfx_stream_ship.play()


func end_level():
	level_ended = true
	background.lock_scale = true


func _on_level_restarted():
	progress = 0.0
	overheat = 0.0
	if background:
		background.reset_scale()
		background.lock_scale = false
	for spawner in spawners:
		spawner.reset()
	level_ended = false
	
	sfx_stream_ship.stream = SFX_ENGINE_NORMAL
	sfx_stream_ship.play()


func _on_next_level():
	next_level.emit()


func _on_end_run():
	end_run.emit()
