class_name Player
extends CharacterBody3D

@export var anim_player: AnimationPlayer
@export var weapon_anim_plr: AnimationPlayer
@export var flash_anim_plr: AnimationPlayer

var movement_vector := Vector3.ZERO
var gravity: float = 9.8
@export var speed: float = 20.0
@export var accel: float = 2.0
@export var turn_speed: float = 1.0
@export var player_scale: float = 2.0

@onready var current_mask_mesh = $Masks/Default
@export var current_mask: String = "Default"
signal mask_changed

@export var restart_screen: CanvasLayer
@export var in_game_screen: CanvasLayer
signal player_died

var dead = false
var can_move = true

@export var default_mesh: MeshInstance3D
@export var hit_flash_mesh: MeshInstance3D
var hitstun_duration: float = 0.2
@onready var invuln_timer: Timer = $InvulnTimer

func _ready() -> void:
	Global.player = self
	Global.score = 0

func _physics_process(_delta) -> void:
	if dead:
		return
	
	if can_move:
		handle_movement()
	
		player_look_at_cursor()
	

func handle_movement() -> void:
	var horizontal_input := Vector3.ZERO
	horizontal_input.x = Input.get_axis("move_left", "move_right")
	horizontal_input.z = Input.get_axis("move_up", "move_down")
	
	horizontal_input = horizontal_input.normalized() * speed
	
	velocity = movement_vector
	movement_vector = movement_vector.move_toward(horizontal_input, accel)
	if not is_on_floor(): #Keep player grounded
		movement_vector.y -= gravity
	
	if movement_vector:
		anim_player.play("Walk")
	else:
		anim_player.play("RESET")
	
	move_and_slide()

func player_look_at_cursor() -> void:
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	var camera: Camera3D = get_viewport().get_camera_3d()
	
	var ray_origin: Vector3 = camera.project_ray_origin(mouse_position)
	var ray_end: Vector3 = ray_origin + camera.project_ray_normal(mouse_position) * 2000
	
	var ray_query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end, 1)
	var intersection = space_state.intersect_ray(ray_query)
	
	if not intersection.is_empty():
		var pos = intersection.position
		
		var old = transform.basis.orthonormalized()
		look_at(pos)
		var new = transform.basis.orthonormalized()
		
		transform.basis = lerp(old, new, turn_speed) #Player looks at intersection with turn speed
		scale = Vector3.ONE * player_scale
		#look_at(Vector3(pos.x, 0, pos.z)) #Player looks at ray intersection
	
	rotation.x = 0 #Reset the player's rotation to stay vertical
	rotation.z = 0

func equip_mask(mask_type: String) -> void:
	current_mask = mask_type
	mask_changed.emit()
	
	current_mask_mesh.hide()
	
	match mask_type:
		"Default":
			current_mask_mesh = $Masks/Default
		"Dragon":
			current_mask_mesh = $Masks/Dragon
		"Goblin":
			current_mask_mesh = $Masks/Goblin
		"Minotaur":
			current_mask_mesh = $Masks/Minotaur
		"Wolf":
			current_mask_mesh = $Masks/Wolf
	
	current_mask_mesh.show()
	current_mask_mesh.setup()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		current_mask_mesh.attack()

func die():
	if not invuln_timer.is_stopped(): return #Don't get hit immediately after getting hit
	if current_mask != "Default": #If wearing a mask, don't die
		drop_mask()
		return
	
	player_died.emit()
	
	#camera shake
	var camera: MainCamera = get_viewport().get_camera_3d()
	camera.screen_shake(5,10)
	
	collision_layer = 0
	collision_mask = 0
	dead = true
	visible = false
	restart_screen.visible = true
	in_game_screen.visible = false
	print("Player died")

func drop_mask() -> void:
	equip_mask("Default")
	
	invuln_timer.start()
	flash_anim_plr.play("hit_flash")
	
	#camera shake
	var camera: MainCamera = get_viewport().get_camera_3d()
	camera.screen_shake(2,4)
	
	#hitstun
	get_tree().paused = true
	await get_tree().create_timer(hitstun_duration).timeout
	get_tree().paused = false
