extends CanvasLayer

@onready var gameOverLabel: Label = $GameOverLabel

signal restart

func _on_new_game_button_pressed() -> void:
	restart.emit()
