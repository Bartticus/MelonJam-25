extends State
class_name DragonAttack

@export var so: StateObject
@export var distance_for_walk: float = 10
@export var spawnpoint: Node3D
@export var angle: float = 30
@export var fire_sound: AudioStreamPlayer3D
var past_time = 0
var attack_speed = 0.1
const FIREBALL = preload("uid://dp5vbbmbvd42q")


func enter():
	_attack()
func exit():
	pass
func process(delta: float):
	so.look_at_player()
	
	past_time += delta
	if past_time > attack_speed:
		_attack()
		past_time = 0
	
	if so.distance_player_enemy() > distance_for_walk:
		transitioned.emit(self, "DragonMove")

func _attack():
	if randi_range(1,3)==3:
		fire_sound.play()
	var temp = FIREBALL.instantiate()
	temp.position = spawnpoint.global_position
	temp.rotation.y = so.enemy.rotation.y + randf_range(-1, 1) * deg_to_rad(angle)
	get_tree().current_scene.get_node("Fireballs").add_child(temp)

func physics_process(_delta: float):
	pass
