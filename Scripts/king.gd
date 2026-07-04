extends Control

var points: int = -1
var add_amount: int = 1
var auto_enabled: bool = 0
var mult_amount: int = 0
var mult_cost: int = 50
var chemistry_enabled: bool = 0
var cap: int = 100
var counter: int = -1
var elements: Array = [null,0,0]
var chance: int = 0

#b0857c is hydrogen

@onready var points_label: RichTextLabel = $Labels/points_label
@onready var timer_1: Timer = $Timers/Timer1
@onready var timer_2: Timer = $Timers/Timer2
@onready var timer_3: Timer = $Timers/Timer3
@onready var meter: Node2D = $Meter
@onready var auto_cost_label: RichTextLabel = $Labels/auto_cost_label
@onready var anim_player: AnimatedSprite2D = $Meter/anim_player
@onready var anim_player_2: AnimatedSprite2D = $Meter2/anim_player
@onready var multi_cost_label: RichTextLabel = $Labels/multi_cost_label
@onready var baklava: TileMapLayer = $Baklava
@onready var cap_label: RichTextLabel = $Labels/cap_label
@onready var chem_label_1: RichTextLabel = $Labels/chemistry_purchase_label
@onready var element_amount_label: RichTextLabel = $Labels/element_amount_label
@onready var element_cost_label: RichTextLabel = $Labels/element_cost_label
@onready var meter_2: Node2D = $Meter2
@onready var reactor_part_1: Sprite2D = $reactor/reactor_part1
@onready var reactor_part_2: Sprite2D = $reactor/reactor_part2
@onready var reactor_part_3: Sprite2D = $reactor/reactor_part3

func add_point(amount):
	if points == cap and amount > 0:
		cap_label.visible = 1
		anim_player.pause()
		timer_1.stop()
	elif (cap - points) < amount:
		points = cap
	else:
		if cap_label.visible and amount < 0:
			cap_label.visible = 0
			anim_player.play()
			timer_1.start()
		points += amount
	points_label.text = str(points)

func auto_trigger():
	auto_enabled = 1
	add_point(-20)
	meter.visible = 1
	auto_cost_label.queue_free()
	multi_cost_label.visible = 1
	anim_player.play("all_eight")
	timer_1.start(2.0)

func buy_mult():
	mult_amount += 1
	add_amount += 1
	add_point(-1 * mult_cost)
	mult_cost *= 4
	multi_cost_label.visible = 0
	if mult_amount == 1:
		chem_label_1.visible = 1

func _on_timer_1_timeout() -> void:
	add_point(add_amount)

func begin_chemistry():
	chemistry_enabled = 1
	add_point(-100)
	baklava.set_cell(Vector2i(31, 15), 0, Vector2i(1, 0))
	baklava.set_cell(Vector2i(31, 14), 0, Vector2i(1, 0))
	chem_label_1.queue_free()
	multi_cost_label.visible = 1
	multi_cost_label.bbcode_text = "Cost: [color=red]200[/color] Points (Multi)"

func first_hydrogen():
	timer_2.start(1.5)
	add_element(1, 1)

func _on_timer_2_timeout() -> void:
	counter += 1
	if not counter:
		for i in range(5):
			baklava.set_cell(Vector2i(32 + i, 12), 0, Vector2i(1, 0))
		for i in range(3):
			baklava.set_cell(Vector2i(33 + i, 13), 0, Vector2i(4 + i, 2))
	if counter == 1:
		for i in range(5):
			baklava.set_cell(Vector2i(32 + i, 11), 0, Vector2i(1, 0))
		for i in range(3):
			baklava.set_cell(Vector2i(33 + i, 12), 0, Vector2i(4 + i, 0))
	if counter == 2:
		element_amount_label.visible = 1
		element_amount_label.bbcode_text = "[color=#b0857c]H: " + str(elements[1]) + "\n(" + str(chance * 10) + "%)"
		element_cost_label.visible = 1
		timer_2.stop()

func add_element(element: int, amount: int):
	elements[element] += amount
	element_amount_label.bbcode_text = "[color=#b0857c]H: " + str(elements[1]) + "\n(" + str(chance * 10) + "%)"

func increase_chance(_element: int):
	chance += 1
	add_element(1, -1)
	if chance == 1:
		meter_2.visible = 1
		anim_player_2.play("all_eight")
		timer_3.start(2.0)
		element_cost_label.bbcode_text = "Cost: 5 [color=#b0857c]H[/color] \n(Part 1)"

func _on_timer_3_timeout() -> void:
	if (randi() % 10) < chance:
		add_element(1, 1)

func add_part(part: int):
	counter += 1
	if part == 1:
		add_element(1, -5)
		reactor_part_1.visible = 1
		element_cost_label.visible = 0
