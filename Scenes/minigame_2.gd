extends Node2D
@onready var themed_timer: Node2D = $ThemedTimer

var buttons_pressed := 0
var timer_end = false

func _ready() -> void:
	await themed_timer.Timer(6.0)
	timer_end = true 


func _process(delta: float) -> void:
	if buttons_pressed == 8:
		if Global.minigames_done >= 2:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/done_scene.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_scene.tscn")
	
	if timer_end:
		Global.lives -= 1
		Global.minigames_done -=1
		if Global.lives == 0:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/lost_scene.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://Scenes/level_scene.tscn")
