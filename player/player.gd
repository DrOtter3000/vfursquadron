extends PathFollow3D

@export_category("Player Stats")
@export var max_hitpoints := 5
@export var direct_speed := 7.0
@export var speed := 0.2
@export var primary_damage := 1
@export var fire_rate := 10.0 #shoots per second
@export var max_boost := .4
@export var boost_accel := 2.0
@export var boost_decel := 1.0

@export_category("Level Stats")
@export var max_pos_x := 10.0
@export var max_pos_y := 10.0

@export_category("Packed Scenes")
@export var hit_particle_instance: PackedScene

var hitpoints: int = max_hitpoints
var primary_fire_ready = true
var basic_fov: float
var basic_speed: float

#@onready var main_animation: AnimationPlayer = $"../MainAnimation"
@onready var model: Node3D = $Model
@onready var camera: Camera3D = $Model/Camera3D
@onready var aim_raycast: RayCast3D = $Model/Camera3D/AimRaycast
@onready var fire_rate_timer: Timer = $FireRateTimer


func _ready() -> void:
	basic_speed = speed
	model.max_pos_x = max_pos_x
	model.max_pos_y = max_pos_y
	model.speed = direct_speed
	fire_rate_timer.wait_time = 1 / fire_rate
	basic_fov = camera.fov

func _process(delta: float) -> void:
	# Progress by path follow
	progress += speed
	
	boost_ship(delta)
	
	set_fov()
	
	if Input.is_action_pressed("fire"):
		fire_primary()

func boost_ship(delta) -> void:
	if Input.is_action_pressed("boost"):
		speed = lerp(speed, max_boost, delta * boost_accel)
	else:
		speed = lerp(speed, basic_speed, delta * boost_decel)

func set_fov() -> void:
	camera.fov = basic_fov * (1 + speed)

func take_damage(amount: int):
	hitpoints -= amount

func fire_primary() -> void:
	if not primary_fire_ready:
		return
	
	primary_fire_ready = false
	var mouse_position = get_viewport().get_mouse_position()
	var target = camera.project_local_ray_normal(mouse_position) * 10000.0
	fire_rate_timer.start()
	aim_raycast.target_position = target
	aim_raycast.force_raycast_update()
	
	var collider = aim_raycast.get_collider()
	
	if collider != null:
		var hit_particles = hit_particle_instance.instantiate()
		var hit_position: Vector3 = aim_raycast.get_collision_point()
		
		if collider is Enemy:
			collider.take_damage(primary_damage)
		
		get_tree().get_root().add_child(hit_particles)
		hit_particles.global_position = hit_position

func _on_fire_rate_timer_timeout() -> void:
	primary_fire_ready = true
