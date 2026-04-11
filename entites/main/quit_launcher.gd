extends Button

@onready var window: Window = $"../../../Window"


func _on_pressed() -> void:
	window.visible = true
	
