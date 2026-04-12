extends Panel


func _on_yes_pressed() -> void:
	Main.save_data()
	get_tree().quit
