extends Area2D


@export var speed := 400.0


func _ready():
	body_entered.connect(_on_body_entered)


func _process(delta):
	position.x -= speed * delta

	# delete when off screen
	if position.x < -200:
		queue_free()


func _on_body_entered(body):
	if body.name == "Player":
		var game = get_parent()

		if game.has_method("player_hit"):
			game.player_hit()
