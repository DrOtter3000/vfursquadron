extends Node3D

# TODO: Try RigidBody

@export var max_hitpoints := 5
@export var speed := 10.0
@export var max_pos_x := 10.0
@export var max_pos_y := 10.0

var hitpoints: int = max_hitpoints

@onready var model: Node3D = $Model

func _ready() -> void:
	model.max_pos_x = max_pos_x
	model.max_pos_y = max_pos_y
	model.speed = speed

func take_damage(amount: int):
	hitpoints -= amount
	print(hitpoints)

func _on_collision_area_body_entered(body: Node3D) -> void:
	# TODO: add individual damage
	take_damage(1)
