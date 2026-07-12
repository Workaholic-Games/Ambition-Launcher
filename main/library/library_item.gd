extends TextureButton

@export var game_name : String
@export var game_file_display_names : PackedStringArray
@export var version_file_names_windows : PackedStringArray
@export var version_file_names_mac : PackedStringArray
@export var version_file_names_linux : PackedStringArray
@export var folder_path : String = "user://Test"
@export var save_data : PackedStringArray
@export var font_size : int = 16

@onready var save_path = get_root_userdata_path() + "/" + save_data[selected_version]

var installed : bool = false
var selected_version : int = -1
var ui_to_back : Array[int] = []

func get_root_userdata_path() -> String:
	var path = ProjectSettings.globalize_path("user://")
	
	var target = "app_userdata"
	var index = path.find(target)
	
	if index != -1:
		return path.substr(0, index + target.length())
	return path

func _ready() -> void:
	$"VBoxContainer/Game Label".text = game_name
	$"VBoxContainer/Game Label".add_theme_font_size_override("font_size", font_size)
	
	if Main.launcher_data.last_played == self.name:
		get_parent().call_deferred("move_child", self, 0)
	check()

# Boot up version of game
func _on_pressed() -> void:
	if selected_version == -1 or ui_to_back.is_empty():
		return
	
	var actual_index = ui_to_back[selected_version]
	var absolute_path = ProjectSettings.globalize_path(folder_path + "//Ambition_Installer_Windows.exe")
	
	match Main.operating_system:
		"Windows":
			absolute_path = ProjectSettings.globalize_path(folder_path + "//" + version_file_names_windows[actual_index] + ".exe")
			OS.shell_open(absolute_path)
		"macOS":
			absolute_path = ProjectSettings.globalize_path(folder_path + "//" + version_file_names_mac[actual_index] + ".app")
			OS.shell_open(absolute_path)
	
	Main.launcher_data.last_played = self.name
	get_parent().move_child(self, 0)



# Uninstall Version of game
func _on_uninstall_pressed() -> void:
	if selected_version == -1 or ui_to_back.is_empty():
		return 
			
	var actual_index = ui_to_back[selected_version]
	var full_path = ""
		
	match Main.operating_system:
		"Windows":
			full_path = ProjectSettings.globalize_path(folder_path + "/" + version_file_names_windows[actual_index] + ".exe")
			OS.move_to_trash(full_path)
			if !str(DirAccess.open(folder_path).get_files()).contains(".exe"):
				remove_recursive(folder_path)
		"macOS":
			full_path = ProjectSettings.globalize_path(folder_path + "/" + version_file_names_mac[actual_index] + ".app")
			OS.move_to_trash(full_path)
		"Linux":
			full_path = ProjectSettings.globalize_path(folder_path + "/" + version_file_names_linux[actual_index])
			OS.move_to_trash(full_path)
	installed = false
	check()


# Check if any versions of game exist
func check():
	$Versions.clear()
	visible = false
	ui_to_back.clear()
	selected_version = -1
	$VBoxContainer/Update.visible = false
	
	for i in range(game_file_display_names.size()):
		var is_installed = false
		
		match Main.operating_system:
			"Windows":
				if i < version_file_names_windows.size():
					var path = folder_path + "//" + version_file_names_windows[i] + ".exe"
					is_installed = FileAccess.file_exists(path)
			"macOS":
				if i < version_file_names_mac.size():
					var path = folder_path + "//" + version_file_names_mac[i] + ".app"
					is_installed = DirAccess.dir_exists_absolute(path)

		if is_installed == true:
			$Versions.add_item(game_file_display_names[i])
			ui_to_back.append(i)
		
		
	if $Versions.item_count > 0:
		installed = true
		visible = true
		$Versions.select(0)
		_on_versions_item_selected(0)
		if $Versions.get_item_text(0) != game_file_display_names.get(0):
			$VBoxContainer/Update.visible = true
	else:
		if DirAccess.dir_exists_absolute(folder_path):
			DirAccess.remove_absolute(folder_path)



# Version Selector
func _on_versions_item_selected(index: int) -> void:
	selected_version = index

# Hover VFX
func _on_mouse_entered() -> void:
	$Hover.visible = true
	$"VBoxContainer/Game Label".visible = true
func _on_mouse_exited() -> void:
	$Hover.visible = false
	$"VBoxContainer/Game Label".visible = false

func remove_recursive(path: String) -> void:
	var dir = DirAccess.open(path)
	if dir:
		for dir_name in DirAccess.get_directories_at(path):
			remove_recursive(path.path_join(dir_name))

		for file_name in DirAccess.get_files_at(path):
			DirAccess.remove_absolute(path.path_join(file_name))
		
		DirAccess.remove_absolute(path)
	else:
		print("An error occurred when trying to access the path: ", path)


func _on_texture_button_pressed() -> void:
	save_path = get_root_userdata_path() + "/" + save_data[selected_version]
	OS.shell_open(save_path)
	print(save_data)
	print(save_path)
	print(selected_version)
