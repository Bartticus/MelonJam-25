extends Node

@export var curve: Curve
var number_of_enemy = 1

@export var timer: Timer

@export var spawn_points: Array[Marker3D]

var distance_from_center = 10
const ENEMIES = [
	preload("uid://bigdgogdou3vp"), 
	preload("uid://cwcp6ckkq3arf"),
	preload("uid://bdnyc3xaifmi6"),
	preload("uid://c175qc057mbv2")
]

func _ready() -> void:
	timer.wait_time = curve.sample(0)
	timer.start(1)

func _spawn_enemy():
	#var index = randi_range(0, 3)
	#var pos = Vector3.RIGHT * distance_from_center
	#pos = pos.rotated(Vector3.UP, randi_range(0, 3) * PI/2)
	for i in number_of_enemy:
		randomize()
		var pos = spawn_points.pick_random().global_position
		var temp = ENEMIES.pick_random().instantiate()
		temp.position = pos
		add_child(temp)
		temp.look_at(Vector3(0,2,0))
		
		await get_tree().create_timer(0.1).timeout #Space out spawns a bit
	
	number_of_enemy += 1
	timer.wait_time = curve.sample(number_of_enemy / 4.0)
