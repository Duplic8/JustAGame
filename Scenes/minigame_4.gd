extends Node2D


@onready var spawn_timer: Timer = $SpawnTimer
@onready var themed_timer: Node2D = $ThemedTimer
@onready var player: CharacterBody2D = $Player
@onready var obstacle_node = $obstacle


var game_over := false
var score := 0


func _ready():
	randomize()
	

	# Hide the original obstacle because it is only a template
	obstacle_node.hide()
	obstacle_node.set_process(false)

	# Start spawning cars
	spawn_timer.timeout.connect(spawn_obstacle)
	spawn_timer.wait_time = randf_range(1.2, 2.5)
	spawn_timer.start()
	await themed_timer.Timer(20.0)
	game_over = true


func spawn_obstacle():
	if game_over:
		if Global.minigames_done >= Global.total_minigames:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/done_scene.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_scene.tscn")

	var new_obstacle = obstacle_node.duplicate()

	# Spawn location
	new_obstacle.position = Vector2(1255, 568)

	new_obstacle.show()
	new_obstacle.add_to_group("obstacles")

	add_child(new_obstacle)

	# Random delay before next car
	spawn_timer.wait_time = randf_range(1.2, 2.8)
	spawn_timer.start()


func delete_all_obstacles():
	for obstacle in get_tree().get_nodes_in_group("obstacles"):
		if is_instance_valid(obstacle):
			obstacle.queue_free()


func player_hit():
	if game_over:
		return

	game_over = true

	spawn_timer.stop()

	# Remove all cars
	delete_all_obstacles()

	# Stop player
	player.set_physics_process(false)

	Global.lives -= 1
	Global.minigames_done -= 1

	if Global.lives == 0:
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/lost_scene.tscn")
	else:
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_scene.tscn")
