extends CharacterBody2D

@export var START_SPEED = 450.0
@export var ACCELERATION = 50.0

func _ready():
	reset_ball()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		velocity = velocity.normalized() * (velocity.length() + ACCELERATION)

func reset_ball():
	global_position = Vector2(576, 324) 
	
	# Forces direction to the right (towards your 'wall' node inside 'Walls')
	var x_dir = 1.0 
	var y_dir = randf_range(-0.5, 0.5)
	
	velocity = Vector2(x_dir, y_dir).normalized() * START_SPEED
