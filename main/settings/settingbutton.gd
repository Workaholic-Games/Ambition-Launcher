extends Button
@export_enum("Window", "Theme", "Startup", "Cursor", "Music") var setting_type : String
@export var setting_value : String

func _on_pressed() -> void:
	match setting_type:
		"Window":
			match setting_value:
				"Windowed":
				"Maximized"
				DisplayServer.window_set_mode()
