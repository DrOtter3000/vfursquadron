extends Node3D

@export var speed := 10.0
@export var max_pos_x := 10.0
@export var max_pos_y := 10.0

@onready var model: Node3D = $Model

func _process(delta: float) -> void:
	control_model(delta)

func control_model(delta: float):
	var direction = Input.get_vector("left", "right", "down", "up").normalized()
	
	if model.position.x > max_pos_x and direction.x > 0:
		direction.x = 0
	elif model.position.x < -max_pos_x and direction.x < 0:
		direction.x = 0
	
	if model.position.y > max_pos_y and direction.y > 0:
		direction.y = 0
	elif model.position.y < -max_pos_y and direction.y < 0:
		direction.y = 0
	
	model.position += Vector3(direction.x, direction.y, 0) * delta * speed
