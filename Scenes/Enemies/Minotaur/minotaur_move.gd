extends State
class_name MinotaurMove

@export var so: StateObject
@export var distance_for_attack := 3.0


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
	
	var dot_product = -so.enemy.global_transform.basis.z.dot(direction)
	
	if so.distance_player_enemy() < distance_for_attack and dot_product > so.min_dot_product:
		transitioned.emit(self, "MinotaurAttack")
