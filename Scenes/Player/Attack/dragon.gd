extends AttackSetup

@export var dagger: Node3D 
@export var axe: Node3D
const FIREBALL = preload("uid://b8xdj10yc4v85")
@export var spawnpoint: Node3D
@export var player: Player

@export var timer: Timer
var can_shoot = true

func setup():
	masks_node.setup()
	
	player.turn_speed = 0.05
	player.speed = 10
	player.accel = 1

func attack():
	if can_shoot:
		var temp = FIREBALL.instantiate()
		temp.position = spawnpoint.global_position
		temp.rotation.y = player.rotation.y
		
		var sphere: CSGSphere3D = temp.get_node("CSGSphere3D")
		sphere.material.albedo_color = Color.YELLOW
		var light: OmniLight3D = temp.get_node("OmniLight3D")
		light.light_color = Color.YELLOW
		
		get_tree().current_scene.get_node("Fireballs").add_child(temp)
		can_shoot = false
		timer.start()

func _on_timer_timeout() -> void:
	can_shoot = true
