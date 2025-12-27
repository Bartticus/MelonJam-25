extends State
class_name MinotaurAttack

@export var so: Node

func enter():
	so.anim_player.play("swing")
func exit():
	pass
func process(delta: float):
	pass
func physics_process(delta: float):
	pass

func end_of_anim():
	so.anim_player.play("RESET")
	transitioned.emit(self, "MinotaurMove")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == Global.player:
		Global.player.get_damage()
