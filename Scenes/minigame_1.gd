extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer

var coin_collected = 0
var timer_end = false

func _ready() -> void:
	await themed_timer.Timer(7.0)
	timer_end = true

func _process(_delta: float) -> void:
	if timer_end:
		Global.minigames_done -= 1
		Global.lives -= 1
		if Global.lives == 0:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/lost_scene.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_scene.tscn")

func coin_collect() -> void:
	coin_collected += 1
	print("Coins collected:", coin_collected)

	if coin_collected == 3:
		if Global.minigames_done >= 2:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/done_scene.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_scene.tscn")
