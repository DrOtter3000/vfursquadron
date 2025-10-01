extends Area3D

@export var speed := 10

var player_model
var player_pos
var direction
var last_pos


func _ready() -> void:
	# TODO: take data from enemy
	await get_tree().create_timer(.01).timeout
	player_model = get_tree().get_first_node_in_group("PlayerModel")
	player_pos = player_model.global_position
	look_at(player_pos)

func _process(delta: float) -> void:
	process_movement(delta)

func process_movement(delta):
	last_pos = global_position
	global_position -= global_transform.basis.z * speed * delta

func _on_timer_timeout() -> void:
	queue_free()
