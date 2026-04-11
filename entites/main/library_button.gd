extends Button

func _on_pressed() -> void:
	$Library.visible = true
	$"../Store/Store".visible = false
