extends Button
@onready var window: Window = $"../.."


func _on_pressed() -> void:
	window.visible = false

	
