class_name Weapon
extends Area3D

@export var punch_sound: AudioStreamPlayer3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemies"):
		punch_sound.play()
		body.die()
