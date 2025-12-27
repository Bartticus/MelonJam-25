extends Node

@export var speed = 100
@export var enemy: CharacterBody3D
@export var anim_player: AnimationPlayer

func distance_player_enemy():
	return (Global.player.position - enemy.position).length()

func look_at_player() -> void:
	var point = Global.player.position
	point.y = enemy.position.y
	enemy.look_at(point)
