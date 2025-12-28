class_name PlayerDefault
extends State

@export var dragon_mesh: MeshInstance3D
@export var goblin_mesh: MeshInstance3D
@export var minotaur_mesh: MeshInstance3D
@export var wolf_mesh: MeshInstance3D


func enter():
	await get_tree().create_timer(0.1).timeout #throws an error without this
	await Global.player.mask_changed
	change_state()

func exit():
	pass

func process(_delta: float) -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func change_state() -> void:
	match Global.player.current_mask:
		"Dragon":
			dragon_mesh.show()
			transitioned.emit(self, "PlayerDragon")
			#other dragon stuff
			pass
		"Goblin":
			goblin_mesh.show()
			transitioned.emit(self, "PlayerGoblin")
			#goblin stuff
			pass
		"Minotaur":
			minotaur_mesh.show()
			transitioned.emit(self, "PlayerMinotaur")
			#mino stuff
			pass
		"Wolf":
			wolf_mesh.show()
			transitioned.emit(self, "PlayerWolf")
			#wolf stuff
			pass
		
