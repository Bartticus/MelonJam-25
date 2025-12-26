extends CharacterBody3D

var player
const speed = 100

func _ready() -> void:
	#Change Dummy to player in future
	player = get_tree().current_scene.get_node("Dummy")

func _physics_process(delta: float) -> void:
	var direction = position.direction_to(player.position)
	velocity = direction * speed * delta
	move_and_slide()
