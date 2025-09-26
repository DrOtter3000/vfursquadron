class_name Enemy
extends CharacterBody3D

@export var max_hitpoints := 3

var hitpoints

func _ready() -> void:
	hitpoints = max_hitpoints

func take_damage(value):
	hitpoints -= value
	if hitpoints <= 0:
		die()

func die():
	queue_free()
