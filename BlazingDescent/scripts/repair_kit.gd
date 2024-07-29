extends Spawnable


func initialize(spawn_location, spawn_direction, spawn_speed, lifespan):
	super.initialize(spawn_location, spawn_direction, spawn_speed, lifespan)
	zoom_speed *= 2.0
	initial_scale = 0.5
	max_scale = 2.0


func _on_area_2d_body_entered(body):
	body.on_collision(Const.CollisionType.REPAIR_KIT)
	queue_free()
