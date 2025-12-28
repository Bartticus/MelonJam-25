class_name GoblinMove
extends State

@export var so: StateObject
@export var distance_for_attack := 3.0
@export var follow_player_radius: float = 10.0

var walking: bool = false
var walk_radius: float = 30.0
var target_pos: Vector3

func enter():
	pass
func exit():
	pass
func process(_delta: float):
	pass
func physics_process(delta: float):
	if so.distance_player_enemy() < distance_for_attack:
		transitioned.emit(self, "GoblinAttack")
	
	if so.distance_player_enemy() < follow_player_radius:
		var direction = so.enemy.position.direction_to(Global.player.position)
		so.enemy.velocity = direction * so.speed * delta
		so.look_at_player()
	else:
		find_walking_target(delta)
	
	so.enemy.move_and_slide()

func find_walking_target(delta: float) -> void:
	if not walking or so.enemy.get_real_velocity().length() < 1.0: #Will pick a new spot after arriving or when it gets stuck
		var rand_angle = randf_range(0.0, TAU) #Math for picking position
		var radial_pos = Vector2.RIGHT.rotated(rand_angle) * walk_radius
		target_pos = Vector3(radial_pos.x, 0, radial_pos.y)
	
	if (target_pos - so.enemy.position).length() > 1.0:
		walking = true
		
		var direction = so.enemy.position.direction_to(target_pos)
		so.enemy.velocity = direction * so.speed * delta
		so.enemy.look_at(target_pos)
	else:
		walking = false
	
