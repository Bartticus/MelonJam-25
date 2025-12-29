extends AttackSetup

@export var player: Node3D
@onready var timer = $Timer
@onready var area = $Weapon

var dash_speed = 30

func setup():
	masks_node.setup()

func attack():
	if player.can_move:
		player.can_move = false
		area.monitoring = true
		timer.start()

func _physics_process(_delta: float) -> void:
	if not player.can_move:
		player.velocity = -player.transform.basis.z * dash_speed
		player.move_and_slide()

func _on_timer_timeout() -> void:
	area.monitoring = false
	player.can_move = true
