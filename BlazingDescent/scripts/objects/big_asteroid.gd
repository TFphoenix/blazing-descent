extends Spawnable


func initialize(spawn_location, spawn_direction, spawn_speed, lifespan):
	super.initialize(spawn_location, spawn_direction, spawn_speed, lifespan)
	zoom_speed *= 10.0
	initial_scale = 0.5
	max_scale = 5.0
	
	# Determine asteroid type
	var random_type = "big_asteroid_%s" % str(randi_range(1, 3))
	$AnimatedSprite2D.play(random_type)


func _on_area_2d_body_entered(body):
	body.on_collision(Const.CollisionType.BIG_ASTEROID)
	queue_free()
