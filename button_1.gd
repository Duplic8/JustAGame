extends TextureButton

@onready var parent = $".."

func _on_pressed() -> void: 
	hide()
	parent.buttons_pressed += 1
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass
