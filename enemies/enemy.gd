class_name Enemy
extends CharacterBody3D

@export var max_hitpoints := 3
@export var range := 500

@export var projectile: PackedScene = preload("res://projectiles/projectile.tscn")

var hitpoints
var player_model
var fire_ready

@onready var player_raycast: RayCast3D = $PlayerRaycast
@onready var projectile_spawn_position: Node3D = $ProjectileSpawnPosition
@onready var fire_rate_timer: Timer = $FireRateTimer


func _ready() -> void:
	hitpoints = max_hitpoints
	player_model = get_tree().get_first_node_in_group("PlayerModel")

func _process(delta: float) -> void:
	if look_for_player() and fire_ready:
		fire_ready = false
		fire_rate_timer.start()
		open_fire()

# TODO: Rename function
func look_for_player() -> bool:
	player_raycast.force_raycast_update()
	player_raycast.look_at(player_model.global_position)
	var collider = player_raycast.get_collider()
	return collider == player_model

func open_fire() -> void:
	var projectile_instance = projectile.instantiate()
	get_tree().get_root().add_child(projectile_instance)
	projectile_instance.global_position = projectile_spawn_position.global_position

func take_damage(value) -> void:
	hitpoints -= value
	if hitpoints <= 0:
		die()

func die() -> void:
	queue_free()

func _on_fire_rate_timer_timeout() -> void:
	fire_ready = true
