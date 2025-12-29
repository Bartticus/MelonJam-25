extends AttackSetup

@export var player: Player
@onready var timer = $Timer
@onready var attack_timer = $AttackTimer
@onready var area = $Weapon
@onready var dash_sound = $AudioStreamPlayer3D

var dash_speed = 30
var can_attack = true

func setup():
	masks_node.setup()

	player.turn_speed = 0.5
	player.speed = 30

func attack():
	if not can_attack: return
	can_attack = false
	attack_timer.start()
	
	if player.can_move:
		player.can_move = false
		area.monitoring = true
		timer.start()
		player.collision_layer = 0b00 #Disable physics layer so he will not die
		dash_sound.play()

func _physics_process(_delta: float) -> void:
	if not player.can_move:
		player.velocity = -player.transform.basis.z * dash_speed
		player.move_and_slide()

func _on_timer_timeout() -> void:
	area.monitoring = false
	player.can_move = true
	player.collision_layer = 0b10 #Enabling back player layer


func _on_attack_timer_timeout() -> void:
	can_attack = true
