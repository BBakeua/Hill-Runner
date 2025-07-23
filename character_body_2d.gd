extends CharacterBody2D

# Editable movement parameters
@export var speed : float = 200.0
@export var jump_velocity : float = -300.0
@export var gravity : float = 980.0

# Animation node reference
@onready var animated_sprite = $AnimatedSprite2D

# State variables
var is_jumping : bool = false

func _physics_process(delta):
	# Apply gravity
	velocity.y += gravity * delta
	
	# Horizontal movement
	var input_direction = Input.get_axis("Move_left", "Move_right")
	velocity.x = input_direction * speed
	
	# Jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
		is_jumping = true
	
	# Update animation
	update_animation(input_direction)
	
	
	
	# Reset jump state if on floor
	if is_on_floor():
		is_jumping = false
		
	# Move the character
	move_and_slide()

func update_animation(input_direction):
	if not is_on_floor():
		animated_sprite.play("Jump")
	elif input_direction != 0:
		animated_sprite.play("Run")
		animated_sprite.flip_h = input_direction < 0
	else:
		animated_sprite.play("Idle")

# Input map setup (set these in Project Settings > Input Map)
# - "move_left": A/left arrow
# - "move_right": D/right arrow
# - "jump": Spacebar
