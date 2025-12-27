extends State
class_name MinotaurMove

@export var so: Node
@export var distance_for_attack := 3.0

func enter():
	pass
func exit():
	pass
func process(delta: float):
	so.look_at_player()
func physics_process(delta: float):
	if so.distance_player_enemy() < distance_for_attack:
		transitioned.emit(self, "MinotaurAttack")
	
	var direction = so.enemy.position.direction_to(Global.player.position)
	so.enemy.velocity = direction * so.speed * delta
	so.enemy.move_and_slide()
