extends Node2D

const ZOOM_STEP = 0.0001

@export var zoom_speed = 100


func _process(delta):
	scale += Vector2(ZOOM_STEP, ZOOM_STEP) * zoom_speed * delta
