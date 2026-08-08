extends TextureButton

@export var game : GameData
@export var menu : Control
var versions : Array = []



func _ready() -> void:
	$"Game Label".text = game.name
	texture_normal = game.cover
	$"Game Label".add_theme_font_size_override("font_size", game.font_size)
	
	if Main.launcher_data.last_played == self.name:
		get_parent().call_deferred("move_child", self, 0)

func _on_mouse_entered() -> void:
	$Hover.visible = true
	$"Game Label".visible = true
func _on_mouse_exited() -> void:
	$Hover.visible = false
	$"Game Label".visible = false

func _on_pressed() -> void:
	get_parent().move_child(self, 0)
	menu.show()

func check():
	versions.clear()
	for i in range(game.version_names.size()):
		var is_installed = false
		
		match Main.operating_system:
			"Windows":
				if i < game.version_file_names_windows.size():
					var path = game.folder_path + "//" + game.version_file_names_windows[i] + ".exe"
					is_installed = FileAccess.file_exists(path)
			"macOS":
				if i < game.version_file_names_mac.size():
					var path = game.folder_path + "//" + game.version_file_names_mac[i] + ".app"
					is_installed = DirAccess.dir_exists_absolute(path)
			"Linux":
				if i < game.version_file_names_mac.size():
					var path = game.folder_path + "//" + game.version_file_names_linux[i]
					is_installed = DirAccess.dir_exists_absolute(path)
		
		if is_installed == true:
			versions.append(game.version_names[i])
		
	if versions.size() > 0:
		show()
	else:
		hide()
