extends Node2D

var is_pressed: bool = 1
var auto_triggered: bool = 0
var text_counter: int = 0
var text = ["Welcome to the game! (Hop on the button!)", "This is an incremental game!", "Your main resource is 'points',", "which you can get more of by pressing the", "big button in the main room!", "Purchase upgrades using points!", "Auto will generate points for you...", "Multi will additively boost point gain!"]

@onready var unpressed: Sprite2D = $unpressed
@onready var pressed: Sprite2D = $pressed
@onready var king: Control = %King
@onready var intro_explainer: RichTextLabel = $"../../Labels/intro_explainer"

func toggle_button():
	is_pressed = !is_pressed
	if is_pressed:
		pressed.visible = 1
		unpressed.visible = 0
	else:
		pressed.visible = 0
		unpressed.visible = 1

func cycle_text():
	intro_explainer.text = text[text_counter]
	text_counter += 1
	text_counter = text_counter % 8

func _on_area_2d_body_entered(_body: Node2D) -> void:
	toggle_button()
	cycle_text()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	toggle_button()
