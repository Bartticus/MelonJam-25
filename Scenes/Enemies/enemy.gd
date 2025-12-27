class_name Enemy
extends CharacterBody3D

const gravity: float = 9.8
@export var mask_scene: PackedScene

func _physics_process(delta: float) -> void:
	pass
	#if not is_on_floor(): #Keep enemy grounded
		#velocity.y -= gravity

func die() -> void:
	#death animation
	#drop mask
	var mask = mask_scene.instantiate() as Mask
	mask.spawn_point = global_position
	mask.mask_type = "Dragon"
	add_sibling(mask)

	queue_free()
