extends Node3D

# TODO: Try RigidBody

@export var max_hitpoints := 5
@export var speed := 10.0
@export var boost_multiplier := 10.0
@export var max_pos_x := 10.0
@export var max_pos_y := 10.0

var hitpoints: int = max_hitpoints

@onready var main_animation: AnimationPlayer = $"../MainAnimation"
@onready var model: Node3D = $Model

func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		main_animation.speed_scale = boost_multiplier
	else:
		main_animation.speed_scale = 1

func _ready() -> void:
	model.max_pos_x = max_pos_x
	model.max_pos_y = max_pos_y
	model.speed = speed

func take_damage(amount: int):
	hitpoints -= amount
	print(hitpoints)
