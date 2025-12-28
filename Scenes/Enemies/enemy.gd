class_name Enemy
extends CharacterBody3D

@export var mask_scene: PackedScene
@export var enemy_type: String

func _physics_process(_delta: float) -> void:
	pass

func die() -> void:
	#death animation
	#drop mask
	var mask = mask_scene.instantiate() as Mask
	mask.spawn_point = global_position
	mask.mask_type = enemy_type
	add_sibling(mask)

	queue_free()
