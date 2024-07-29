extends Node2D

# Scene parameters
@export var origin: Marker2D

# Spawn parameters
@export var should_spawn = false
@export var spawn_rate = 0.1
@export var spawn_iteration_max_entities = 3

# Entity parameters
@export var entity_scene: PackedScene
@export var entity_lifespan = 3.0
@export var entity_min_speed = 150.0
@export var entity_max_speed = 300.0


func _ready():
	$Timer.wait_time = spawn_rate
	$Timer.start()


func _on_spawn():
	if should_spawn:
		var entities = randi_range(1, spawn_iteration_max_entities)
		for i in range(entities):
			spawn()


func spawn():
	var entity = entity_scene.instantiate()
	var random_direction = get_random_direction()
	var random_speed = randf_range(entity_min_speed, entity_max_speed)
	entity.initialize(origin.position, random_direction, random_speed, entity_lifespan)
	add_child(entity)


func get_random_direction():
	var x = randf_range(-1, 1)
	var y = randf_range(-1, 1)
	return Vector2(x, y).normalized()


func reset():
	var entities = get_children()
	for entity in entities:
		if not entity is Timer:
			entity.queue_free()
