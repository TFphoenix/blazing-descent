extends Node2D
class_name LevelManager

const PROGRESS_RATE = 0.015

# Scene references
@export var hud: Control
@export var background: Node
@export var spawners: Array[Node]

# Signals
signal end_run
signal next_level

var level_ended = false

# Atmospheres
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


func _ready():
	hud.restart_level.connect(_on_level_restarted)
	hud.next_level.connect(_on_next_level)
	hud.end_run.connect(_on_end_run)


func _process(delta):
	# Update progress
	progress += PROGRESS_RATE * delta
	
	# Update overheat
	overheat += atmospheres[current_atmosphere]['overheat_rate'] * delta
	
	# Next atmosphere
	if next_atmosphere < atmospheres.size() and progress >= atmospheres[next_atmosphere]:
		current_atmosphere = next_atmosphere
		next_atmosphere += 1
		


func on_collision(type: Const.CollisionType):
	overheat += Const.OVERHEAT[type]
	hud.update_overheat(overheat)


func _on_level_passed():
	if level_ended: return
	end_level()
	hud.display_passed()


func _on_level_failed():
	if level_ended: return
	end_level()
	hud.display_failed()


func end_level():
	level_ended = true
	background.lock_scale = true


func _on_level_restarted():
	progress = 0.0
	overheat = 0.0
	if background: background.reset_scale()
	for spawner in spawners:
		spawner.reset()
	level_ended = false
#

func _on_next_level():
	next_level.emit()


func _on_end_run():
	end_run.emit()
