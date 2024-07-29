extends Node2D

const ZOOM_STEP = 0.01

@export var initial_scale = 0.25
@export var zoom_speed = 100

const TEXT_PLANET = "planet_%1d"
@onready var planet = $Planet

var lock_scale = false

func _ready():
	reset_scale()


func _process(delta):
	if !lock_scale:
		scale += Vector2(ZOOM_STEP, ZOOM_STEP) * zoom_speed * delta


func reset_scale():
	scale = Vector2(initial_scale, initial_scale)


func set_planet(planet_idx: int):
	planet.play(TEXT_PLANET % planet_idx)
