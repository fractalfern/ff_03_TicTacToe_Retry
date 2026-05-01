extends Node2D

@export var button_group: ButtonGroup

signal opponent_select(button: BaseButton)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_group.pressed.connect(_on_button_group_pressed)

func _on_button_group_pressed(button: BaseButton):
	opponent_select.emit(button)
