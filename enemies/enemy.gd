class_name Enemy
extends CharacterBody3D

@export var max_hitpoints := 3
@export var range := 500

var hitpoints
var player_model

@onready var player_raycast: RayCast3D = $PlayerRaycast


func _ready() -> void:
	hitpoints = max_hitpoints
	player_model = get_tree().get_first_node_in_group("PlayerModel")

func _process(delta: float) -> void:
	look_for_player()

func look_for_player() -> void:
	player_raycast.force_raycast_update()
	player_raycast.look_at(player_model.global_position)
	var collider = player_raycast.get_collider()

func take_damage(value) -> void:
	hitpoints -= value
	if hitpoints <= 0:
		die()

func die() -> void:
	queue_free()
