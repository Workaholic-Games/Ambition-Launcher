@icon("res://editor_icons/tos.png")
extends Panel

func _ready() -> void:
	if Main.launcher_data.tos == false:
		show()

func _on_deny_pressed() -> void:
	$"../Tap".play()
	get_tree().quit()

func _on_accept_pressed() -> void:
	$"../Tap".play()
	hide()
	Main.launcher_data.tos = true
	Main.save_data()
	$"../Username".show()
