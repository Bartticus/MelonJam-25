extends Node

var distance_from_center = 10
const ENEMIES = [preload("uid://bigdgogdou3vp"), preload("uid://cwcp6ckkq3arf")]

func _ready() -> void:
	_spawn_enemy(0)
	_spawn_enemy(1)

func _spawn_enemy(index):
	var pos = Vector3.RIGHT * distance_from_center
	pos = pos.rotated(Vector3.UP, randf() * TAU)
	var temp = ENEMIES[index].instantiate()
	temp.position = pos
	add_child(temp)
	
