extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -550.0
@onready var jump_buffer_timer: Timer = $JumpBufferTimer


func _physics_process(delta: float) -> void:
	#Smoother jumping to account for jump press buffers
	if Input.is_action_just_pressed("player_jump"):
		jump_buffer_timer.start(.15)
		
	if jump_buffer_timer.time_left > 0 and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_buffer_timer.stop()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := 0
	if Global.minigames_done != 4:
		direction = Input.get_axis("player_left", "player_right")
	if direction:
		if direction < 0:
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
