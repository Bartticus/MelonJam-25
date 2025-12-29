class_name StateObject
extends Node

@export var speed = 100
@export var enemy: CharacterBody3D
@export var anim_player: AnimationPlayer
@export var turn_speed: float = .01
@export var min_dot_product: float = 0.9 #1.0 means only attack when looking directly at player

func distance_player_enemy() -> float:
	return (Global.player.position - enemy.position).length()

func look_at_player() -> void:
	var point = Global.player.position
	point.y = enemy.position.y
	#enemy.look_at(point)
	
	var old = enemy.transform.basis.orthonormalized()
	enemy.look_at(point)
	var new = enemy.transform.basis.orthonormalized()
	enemy.transform.basis = lerp(old, new, turn_speed)
