extends Node2D

const ZOOM_STEP = 0.0001

var speed = 100.0
var direction = Vector2.ZERO
var zoom_speed = 5000.0
var initial_scale = 0.1
var max_scale = 1.0


func initialize(spawn_location, spawn_direction, spawn_speed, lifespan):
	# Set spawn parameters
	position = spawn_location
	scale = Vector2(initial_scale, initial_scale)
	direction = spawn_direction
	speed = spawn_speed
	$Timer.wait_time = lifespan
	
	look_at(direction)
	
	# Determine asteroid type
	var random_type = "asteroid_%s" % str(randi_range(1, 5))
	$AnimatedSprite2D.play(random_type)


func _process(delta):
	position += direction * speed * delta
	if scale.x < max_scale:
		scale += Vector2(ZOOM_STEP, ZOOM_STEP) * zoom_speed * delta


func _on_lifespan_end():
	queue_free()


func _on_area_2d_body_entered(body):
	body.on_asteroid_collision()
	queue_free()
