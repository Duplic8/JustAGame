extends CharacterBody2D

@export var SPEED = 450.0

func _physics_process(_delta):
	var direction = Input.get_axis("player_up", "player_down")
	
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
