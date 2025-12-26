extends Node

var distance_from_center = 10
const ENEMY = preload("uid://qrp2qrl5esb7")

func _ready() -> void:
	_spawn_enemy()
	_spawn_enemy()
	_spawn_enemy()
	_spawn_enemy()
	_spawn_enemy()

func _spawn_enemy():
	var pos = Vector3.RIGHT * distance_from_center
	pos = pos.rotated(Vector3.UP, randf() * TAU)
	var temp = ENEMY.instantiate()
	temp.position = pos
	add_child(temp)
	
