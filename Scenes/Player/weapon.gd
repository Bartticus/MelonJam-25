class_name Weapon
extends Area3D



func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemies"):
		body.die()
