extends CharacterBody2D

@export var level_manager: Node2D

# Movement
@export var speed = 100
@export var target: Marker2D
@export var threshold = 330


func _physics_process(_delta):
	# Look at target
	look_at(target.position)
	
	# Rotate around target
	var distance = position.distance_to(target.position)
	var mouse_position = get_global_mouse_position()
	position = target.position.direction_to(mouse_position) * distance
	
	# Move towards target
	#if distance >= threshold:
		#velocity = position.direction_to(target.position) * speed
	#else:
		#velocity = Vector2.ZERO
	
	move_and_slide()

func on_collision(type: Const.CollisionType):
	level_manager.on_collision(type)
