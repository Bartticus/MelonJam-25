class_name Enemy
extends CharacterBody3D

@export var mask_scene: PackedScene
@export var enemy_type: String
@export var enemy_mask: PackedScene

func _physics_process(_delta: float) -> void:
	pass

func die() -> void:
	#death animation
	#drop mask
	var mask = mask_scene.instantiate() as Mask
	mask.spawn_point = global_position
	mask.mask_type = enemy_type
	var mesh_mask = enemy_mask.instantiate()
	mask.get_node("MeshPivot").add_child(mesh_mask)
	add_sibling(mask)
	Global.score += 1

	queue_free()
