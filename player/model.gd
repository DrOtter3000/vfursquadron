extends CharacterBody3D

var max_pos_x: float
var max_pos_y: float
var speed: float

@onready var camera: Camera3D = $Camera3D
@onready var aim_raycast: RayCast3D = $Camera3D/AimRaycast

func _process(delta: float) -> void:
	control_model(delta)
	move_and_slide()

func control_model(delta: float):
	var direction = Input.get_vector("left", "right", "down", "up").normalized()
	
	if position.x > max_pos_x and direction.x > 0:
		direction.x = 0
	elif position.x < -max_pos_x and direction.x < 0:
		direction.x = 0
	
	if position.y > max_pos_y and direction.y > 0:
		direction.y = 0
	elif position.y < -max_pos_y and direction.y < 0:
		direction.y = 0
	
	position += Vector3(direction.x, direction.y, 0) * delta * speed
