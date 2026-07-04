extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity and shit
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump and shit
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("moveLeft", "moveRight")
	
	#Flip the Script and shit
	if direction > 0:
		animated_sprite.flip_h = 0
	elif direction < 0:
		animated_sprite.flip_h = 1
	
	#Play animation and shit
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")

	#Apply movement and shit
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
