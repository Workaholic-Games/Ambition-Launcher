extends Control
@export var game : GameData
@export var library_item : TextureButton
@onready var save_path = get_root_userdata_path() + "/" + game.save_data_folder_name[selected_version]
var installed : bool = false
var selected_version : int = -1
var ui_to_back : Array[int] = []



func _ready() -> void:
	check()

func get_root_userdata_path() -> String:
	var path = ProjectSettings.globalize_path("user://")
	
	var target = "app_userdata"
	var index = path.find(target)
	
	if index != -1:
		return path.substr(0, index + target.length())
	return path



func _on_versions_item_selected(index: int) -> void:
	selected_version = index


func _on_play_pressed() -> void:
	if selected_version == -1 or ui_to_back.is_empty():
		return
	
	var actual_index = ui_to_back[selected_version]
	var absolute_path = ProjectSettings.globalize_path(game.folder_path + "//Ambition_Installer_Windows.exe")
	
	match Main.operating_system:
		"Windows":
			absolute_path = ProjectSettings.globalize_path(game.folder_path + "//" + game.version_file_names_windows[actual_index] + ".exe")
			OS.shell_open(absolute_path)
		"macOS":
			absolute_path = ProjectSettings.globalize_path(game.folder_path + "//" + game.version_file_names_mac[actual_index] + ".app")
			OS.shell_open(absolute_path)
		"Linux":
			absolute_path = ProjectSettings.globalize_path(game.folder_path + "//" + game.version_file_names_linux[actual_index])
			OS.shell_open(absolute_path)
	
	Main.launcher_data.last_played = self.name

func _on_uninstall_pressed() -> void:
	if selected_version == -1 or ui_to_back.is_empty():
		return 
			
	var actual_index = ui_to_back[selected_version]
	var full_path = ""
		
	match Main.operating_system:
		"Windows":
			full_path = ProjectSettings.globalize_path(game.folder_path + "/" + game.version_file_names_windows[actual_index] + ".exe")
			OS.move_to_trash(full_path)
			if !str(DirAccess.open(game.folder_path).get_files()).contains(".exe"):
				remove_recursive(game.folder_path)
		"macOS":
			full_path = ProjectSettings.globalize_path(game.folder_path + "/" + game.version_file_names_mac[actual_index] + ".app")
			OS.move_to_trash(full_path)
		"Linux":
			full_path = ProjectSettings.globalize_path(game.folder_path + "/" + game.version_file_names_linux[actual_index])
			OS.move_to_trash(full_path)
	installed = false
	check()
	library_item.check()

func _on_folder_pressed() -> void:
	save_path = get_root_userdata_path() + "/" + game.save_data_folder_name[selected_version]
	OS.shell_open(save_path)



func check():
	$Versions.clear()
	ui_to_back.clear()
	selected_version = -1
	
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
			$Versions.add_item(game.version_names[i])
			ui_to_back.append(i)
		
	if $Versions.item_count > 0:
		installed = true
		visible = true
		$Versions.select(0)
		_on_versions_item_selected(0)
		#if $Versions.get_item_text(0) != game.save_data_folder_name.get(0):
			#$VBoxContainer/Update.visible = true
	else:
		get_parent().hide()
		
		if DirAccess.dir_exists_absolute(game.folder_path):
			DirAccess.remove_absolute(game.folder_path)

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

func _on_visibility_changed() -> void:
	check()


func _on_back_pressed() -> void:
	get_parent().hide()
