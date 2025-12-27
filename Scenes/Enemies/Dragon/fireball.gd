extends Area3D

const SPEED = 5

func _physics_process(delta: float) -> void:
	translate(Vector3.FORWARD * SPEED * delta)

func _on_body_entered(body: Node3D) -> void:
	if body == Global.player:
		Global.player.get_damage()
