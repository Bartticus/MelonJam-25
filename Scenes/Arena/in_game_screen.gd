extends CanvasLayer

@onready var text = $Label

func _ready() -> void:
	Global.score_changed.connect(change_text)

func change_text():
	text.text = "Score: " + str(Global.score)
