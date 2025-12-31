extends CanvasLayer

@onready var label = $Label
@onready var sfx : AudioStreamPlayer = $uisfx
@onready var sfx_hover : AudioStreamPlayer = $uiHoversfx
@onready var lose_music : AudioStreamPlayer = $LoseMusic

var skip: bool = false

func _ready() -> void:
	get_tree().paused = false

func _on_visibility_changed() -> void:
	if skip: return
	
	if visible:
		lose_music.play()
		label.show()
		label.text += str(Global.score)

func _on_button_mouse_entered() -> void:
	sfx_hover.play()

func _on_restart_button_pressed() -> void:
	sfx.play()
	get_tree().reload_current_scene()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		skip = true
		if visible:
			get_tree().paused = false
			hide()
			skip = false
		else:
			get_tree().paused = true
			show()
