extends Node2D

var is_opened: bool = 1

@onready var sprite1: Sprite2D = $Sprite2D
@onready var sprite2: Sprite2D = $Sprite2D2
@onready var door_3: Node2D = $"../Door3"

func _on_area_2d_body_entered(_body: Node2D) -> void:
	toggle_door()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	toggle_door()

func toggle_door():
	is_opened = !is_opened
	if is_opened:
		sprite2.visible = 1
		sprite1.visible = 0
	else:
		sprite2.visible = 0
		sprite1.visible = 1
