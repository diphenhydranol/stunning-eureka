extends Node2D

var is_pressed: bool = 1
var auto_triggered: bool = 0

@onready var unpressed: Sprite2D = $unpressed
@onready var pressed: Sprite2D = $pressed
@onready var king: Control = %King

func toggle_button():
	is_pressed = !is_pressed
	if is_pressed:
		pressed.visible = 1
		unpressed.visible = 0
	else:
		pressed.visible = 0
		unpressed.visible = 1

func _on_area_2d_body_entered(_body: Node2D) -> void:
	toggle_button()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	toggle_button()
