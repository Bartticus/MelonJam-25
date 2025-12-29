class_name GoblinAttack
extends State

@export var so: StateObject
@export var hit_sound: AudioStreamPlayer3D


func enter():
	so.anim_player.play("stab")
	hit_sound.play()
	await so.anim_player.animation_finished
	end_of_anim()

func exit():
	pass
func process(_delta: float):
	pass
func physics_process(_delta: float):
	pass

func end_of_anim():
	so.anim_player.play("Walk")
	transitioned.emit(self, "GoblinMove")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == Global.player:
		Global.player.die()
