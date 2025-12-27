extends Node

@export var curve: Curve
var number_of_enemy = 0

@export var timer: Timer

var distance_from_center = 10
const ENEMIES = [
	preload("uid://bigdgogdou3vp"), 
	preload("uid://cwcp6ckkq3arf"),
	preload("uid://bdnyc3xaifmi6"),
]

func _ready() -> void:
	timer.wait_time = curve.sample(0)
	timer.start()

func _spawn_enemy():
	var index = randi_range(0, 2)
	var pos = Vector3.RIGHT * distance_from_center
	pos = pos.rotated(Vector3.UP, randi_range(0, 3) * PI/2)
	var temp = ENEMIES[index].instantiate()
	temp.position = pos
	add_child(temp)
	number_of_enemy += 1
	timer.wait_time = curve.sample(number_of_enemy)
