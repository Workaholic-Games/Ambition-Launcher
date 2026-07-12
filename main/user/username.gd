extends Panel

var username : String = "" 

func _ready() -> void:
	if Main.launcher_data.username == "":
		show()

func _on_line_edit_text_changed(new_text: String) -> void:
	username = new_text

func _on_button_pressed() -> void:
	$"../Tap".play()
	Main.launcher_data.username = username
	hide()
	$"../Reloading".show()
	$"../Reloading/Timer".start()
	Main.save_data()
	$LineEdit.text = ""


func _on_close_pressed() -> void:
	$"../Tap".play()
	hide()
