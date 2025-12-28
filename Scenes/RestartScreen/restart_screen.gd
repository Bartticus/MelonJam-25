extends CanvasLayer

@onready var label = $Label

func _on_visibility_changed() -> void:
	if visible:
		$LoseMusic.play()
		label.text += str(Global.score)
	
