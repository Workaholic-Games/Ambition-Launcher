extends Panel

var username : String = "" 

func _ready() -> void:
	if Main.launcher_data.username != "":
		hide()

func _on_line_edit_text_changed(new_text: String) -> void:
	username = new_text

func _on_button_pressed() -> void:
	Main.launcher_data.username = username
	hide()
