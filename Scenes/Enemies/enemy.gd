class_name Enemy
extends CharacterBody3D

@export var mask_scene: PackedScene
@export var enemy_type: String
@export var enemy_mask: PackedScene
@export var default_mesh: MeshInstance3D
@export var hit_flash_mesh: MeshInstance3D
@export var death_sound: AudioStream
@onready var invuln_timer: Timer = $InvulnTimer

@export var health: int = 1

var hitstun_duration: float = 0.1

func _physics_process(_delta: float) -> void:
	pass

func die() -> void:
	if not invuln_timer.is_stopped(): return #Don't get hit immediately after getting hit
	invuln_timer.start()
	health -= 1
	hit_flash_mesh.show()
	default_mesh.hide()
	
	
	#camera shake
	var camera: MainCamera = get_viewport().get_camera_3d()
	camera.screen_shake(1,2)
	
	#hitstun
	get_tree().paused = true
	await get_tree().create_timer(hitstun_duration).timeout
	get_tree().paused = false
	
	if health > 0:
		await get_tree().create_timer(0.1).timeout
		hit_flash_mesh.hide()
		default_mesh.show()
		return
	#death animation
	#double hitstun on death
	get_tree().paused = true
	await get_tree().create_timer(hitstun_duration).timeout
	get_tree().paused = false
	
	#drop mask
	if randi_range(1,5) == 5 or Global.score == 0: #1 in 5 chance of dropping mask, except the first kill
		var mask = mask_scene.instantiate() as Mask
		mask.spawn_point = global_position
		mask.mask_type = enemy_type
		var mesh_mask = enemy_mask.instantiate()
		mask.get_node("MeshPivot").add_child(mesh_mask)
		add_sibling(mask)
	
	Global.score += 1
	
	var temp = AudioStreamPlayer.new()
	temp.stream = death_sound
	temp.bus = "SFX"
	temp.finished.connect(temp.queue_free)
	add_sibling(temp)
	temp.play()
	
	queue_free()
