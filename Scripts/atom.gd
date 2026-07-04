extends Node2D

@onready var atom: Node2D = $"."
@onready var king: Control = %King

var add: int = 1
var subtract: int = -1
var counter: int = 0

func _on_bounding_box_body_entered(_body: Node2D) -> void:
	queue_free()
	king.first_hydrogen()

func _on_timer_1_timeout() -> void:
	if position[1] == 229 or position[1] == 235:
		add = -add
	if position[1] == 229:
		if position[0] == 533 or position[0] == 539:
			subtract = -subtract
		position[0] += subtract
	position[1] += add
