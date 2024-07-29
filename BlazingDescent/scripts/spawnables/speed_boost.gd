extends Spawnable


func initialize(spawn_location, spawn_direction, spawn_speed, lifespan):
	super.initialize(spawn_location, spawn_direction, spawn_speed, lifespan)
	zoom_speed *= 5.0
	initial_scale = 1.0
	max_scale = 3.0


func _on_area_2d_body_entered(body):
	body.on_collision(Const.CollisionType.SPEED_BOOST)
	queue_free()
