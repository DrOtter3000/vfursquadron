extends Node3D

# TODO: Try RigidBody

@export_category("Player Stats")
@export var max_hitpoints := 5
@export var speed := 10.0
@export var fire_rate := 10.0 #shoots per second
@export var max_boost := 10.0
@export var boost_accel := 2.0
@export var boost_decel := 1.0

@export_category("Level Stats")
@export var max_pos_x := 10.0
@export var max_pos_y := 10.0

var hitpoints: int = max_hitpoints

@onready var main_animation: AnimationPlayer = $"../MainAnimation"
@onready var model: Node3D = $Model
@onready var camera: Camera3D = $Model/Camera3D
@onready var aim_raycast: RayCast3D = $Model/Camera3D/AimRaycast
@onready var fire_rate_timer: Timer = $FireRateTimer

func _ready() -> void:
	model.max_pos_x = max_pos_x
	model.max_pos_y = max_pos_y
	model.speed = speed
	fire_rate_timer.wait_time = 1 / fire_rate

func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		main_animation.speed_scale = lerp(main_animation.speed_scale, max_boost, delta * boost_accel)
	else:
		main_animation.speed_scale = lerp(main_animation.speed_scale, 1.0, delta * boost_decel)
	if Input.is_action_pressed("fire"):
		fire_primary()

func take_damage(amount: int):
	hitpoints -= amount
	print(hitpoints)

func fire_primary() -> void:
	if fire_rate_timer.time_left > 0:
		return
	fire_rate_timer.start()
	var mouse_position = get_viewport().get_mouse_position()
	var target = camera.project_local_ray_normal(mouse_position) * 10000.0
	aim_raycast.target_position = target
	aim_raycast.force_raycast_update()
	print(aim_raycast.get_collider())
	
