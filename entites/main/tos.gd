@icon("res://editor_icons/tos.png")
extends Panel



func _ready() -> void:
	if Main.launcher_data.tos == false:
		visible = true


func _on_deny_pressed() -> void:
	get_tree().quit()



func _on_accept_pressed() -> void:
	visible = false
	Main.launcher_data.tos = true
	Main.save_data()
