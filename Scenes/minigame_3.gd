extends Node2D

var game_over = false
var time_limit = 15.0

@onready var backwall_node = $backwall
@onready var ball_node = $pong
@onready var player_node = $player_pong
@onready var themed_timer: Node2D = $ThemedTimer

func _ready():
	# Connect backwall collision signal (Ensure backwall is an Area2D)
	if backwall_node and backwall_node.has_signal("body_entered"):
		backwall_node.body_entered.connect(_on_backwall_body_entered)
	
	# Start the game loop and timer tracking
	start_game()

func start_game():
	if themed_timer and themed_timer.has_method("Timer"):
		# Await waits directly for your custom countdown loop to completely finish
		await themed_timer.Timer(time_limit)
		
		# If the 20 seconds finish and the player didn't lose, they win!
		if not game_over:
			_on_timer_timeout()

func _on_backwall_body_entered(body):
	if body == ball_node and not game_over:
		game_over = true
		Global.lives -= 1
		Global.minigames_done -= 1
		_end_game()
		
		if Global.lives == 0:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/lost_scene.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_scene.tscn")

func _on_timer_timeout():
	if not game_over:
		game_over = true
		_end_game()
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/done_scene.tscn")

func _end_game():
	ball_node.set_physics_process(false)
	player_node.set_physics_process(false)
