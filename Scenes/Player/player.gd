class_name Player
extends CharacterBody3D

var movement_vector := Vector3.ZERO
var gravity: float = 9.8
@export var speed: float = 20.0
@export var accel: float = 2.0

@export var current_mask: String = "Default"

@export var restart_screen: CanvasLayer

var dead = false

func _ready() -> void:
	Global.player = self

func _physics_process(_delta) -> void:
	if dead:
		return
	
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
		look_at(Vector3(pos.x, 0, pos.z)) #Player looks at ray intersection
	
	rotation.x = 0 #Reset the player's rotation to stay vertical
	rotation.z = 0

func equip_mask(mask_type: String) -> void:
	$PlayerMesh.hide()
	current_mask = mask_type
	
	match mask_type:
		"Dragon":
			$DragonMesh.show()
			#other dragon stuff
			pass
		"Goblin":
			$GoblinMesh.show()
			#goblin stuff
			pass
		"Minotaur":
			$MinotaurMesh.show()
			#mino stuff
			pass
		"Wolf":
			$WolfMesh.show()
			#wolf stuff
			pass
		
func get_damage():
	dead = true
	visible = false
	restart_screen.visible = true
	print("Player died")
