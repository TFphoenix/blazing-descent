extends Node2D

const ZOOM_STEP = 0.0001

@export var initial_scale = 0.25
@export var zoom_speed = 100

var lock_scale = false

func _ready():
	reset_scale()


func _process(delta):
	if !lock_scale:
		scale += Vector2(ZOOM_STEP, ZOOM_STEP) * zoom_speed * delta


func reset_scale():
	scale = Vector2(initial_scale, initial_scale)
