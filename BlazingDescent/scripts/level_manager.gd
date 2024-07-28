extends Node2D
class_name LevelManager

# General
const PROGRESS_RATE = 0.015
@export var hud: Control
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
		if progress >= 1: on_level_completed()
var overheat = 0.0:
	set(value):
		overheat = clamp(value, 0.0, 1.0)
		if overheat >= 1: on_level_failed()


func _process(delta):
	# Update progress
	progress += PROGRESS_RATE * delta
	hud.update_progress(progress)
	
	# Update overheat
	overheat += atmospheres[current_atmosphere]['overheat_rate'] * delta
	hud.update_overheat(overheat)
	
	# Next atmosphere
	if next_atmosphere < atmospheres.size() and progress >= atmospheres[next_atmosphere]:
		current_atmosphere = next_atmosphere
		next_atmosphere += 1
		


func on_collision(type: Const.CollisionType):
	overheat += Const.OVERHEAT[type]
	hud.update_overheat(overheat)


func on_level_completed():
	if level_ended: return

	level_ended = true


func on_level_failed():
	if level_ended: return
	
	level_ended = true
