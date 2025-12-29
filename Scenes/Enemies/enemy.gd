class_name Enemy
extends CharacterBody3D

@export var mask_scene: PackedScene
@export var enemy_type: String
@export var enemy_mask: PackedScene
@export var default_mesh: MeshInstance3D
@export var hit_flash_mesh: MeshInstance3D
var hitstun_duration: float = 0.1

func _physics_process(_delta: float) -> void:
	pass

func die() -> void:
	#death animation
	default_mesh.hide()
	hit_flash_mesh.show()
	
	#drop mask
	if randi_range(1,5) == 5 or Global.score == 0: #1 in 5 chance of dropping mask, except the first kill
		var mask = mask_scene.instantiate() as Mask
		mask.spawn_point = global_position
		mask.mask_type = enemy_type
		var mesh_mask = enemy_mask.instantiate()
		mask.get_node("MeshPivot").add_child(mesh_mask)
		add_sibling(mask)
	
	#camera shake
	var camera: MainCamera = get_viewport().get_camera_3d()
	camera.screen_shake(1,2)
	
	#hitstun
	get_tree().paused = true
	await get_tree().create_timer(hitstun_duration).timeout
	get_tree().paused = false
	
	Global.score += 1
	
	queue_free()
