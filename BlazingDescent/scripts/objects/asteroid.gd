extends Spawnable


func initialize(spawn_location, spawn_direction, spawn_speed, lifespan):
	super.initialize(spawn_location, spawn_direction, spawn_speed, lifespan)
	
	# Determine asteroid type
	var random_type = "asteroid_%s" % str(randi_range(1, 5))
	$AnimatedSprite2D.play(random_type)


func _on_area_2d_body_entered(body):
	body.on_collision(Const.CollisionType.ASTEROID)
	queue_free()
