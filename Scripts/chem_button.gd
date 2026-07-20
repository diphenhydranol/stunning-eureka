extends Node2D

var is_pressed: bool = 1
var auto_triggered: bool = 0
var bulk_check: bool = 0

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
	if not bulk_check and not king.chance[1] and king.elements[1] == 1 and king.counter == 2:
		king.increase_chance(1)
		bulk_check = 1
	if not bulk_check and king.elements[1] >= 5 and king.counter == 3:
		king.add_part(1)
		bulk_check = 1
	if not bulk_check and king.elements[1] >= 10 and king.counter == 4:
		king.increase_cap(1)
		bulk_check = 1
	if not bulk_check and king.elements[1] >= 25 and king.counter == 7:
		king.add_part(3)
		bulk_check = 1
	if not bulk_check and king.elements[1] >= 10 and king.counter == 8:
		king.fuse(1, 1)
		bulk_check = 1

func _on_area_2d_body_exited(_body: Node2D) -> void:
	toggle_button()
	bulk_check = 0
