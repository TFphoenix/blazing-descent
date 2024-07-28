extends Node2D

# General
@export var hud: Control

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
var overheat = 0.0:
	set(value):
		overheat = clamp(value, 0.0, 1.0)


func _process(delta):
	# Update progress
	progress += 0.025 * delta
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
