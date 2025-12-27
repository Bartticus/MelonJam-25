extends State
class_name DragonMove

@export var so: Node
@export var distance_for_attack = 10

func enter():
	pass
func exit():
	pass
func process(_delta: float):
	so.look_at_player()
func physics_process(delta: float):
	var direction = so.enemy.position.direction_to(Global.player.position)
	so.enemy.velocity = direction * so.speed * delta
	so.enemy.move_and_slide()
	
	if so.distance_player_enemy() < distance_for_attack:
		transitioned.emit(self, "DragonAttack")
