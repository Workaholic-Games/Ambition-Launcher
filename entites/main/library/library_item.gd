extends TextureButton

@export var game_name : String
@export var game_file_display_names : PackedStringArray
@export var version_file_names_windows : PackedStringArray
@export var version_file_names_mac : PackedStringArray
@export var version_file_names_linux : PackedStringArray
@export var folder_path : String = "user://Test"

var selected_version : int = -1
var ui_to_back : Array[int] = []

# make only versions you have installed appear
# add checking if theres a new version of whatever app and a respective install button


func _ready() -> void:
	$"Game Label".text = game_name
	
	if Main.launcher_data.last_played == self.name:
		get_parent().call_deferred("move_child", self, 0)
		#get_parent().move_child(self, 0)
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
		"macOS":
			full_path = ProjectSettings.globalize_path(folder_path + "/" + version_file_names_mac[actual_index] + ".app")
			OS.move_to_trash(full_path)
		"Linux":
			full_path = ProjectSettings.globalize_path(folder_path + "/" + version_file_names_linux[actual_index])
			OS.move_to_trash(full_path)
				
	check()


# Check if any versions of game exist
func check():
	$Versions.clear()
	visible = false
	ui_to_back.clear()
	selected_version = -1
	
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

		if is_installed:
			$Versions.add_item(game_file_display_names[i])
			ui_to_back.append(i)
			print(ui_to_back)
		
	if $Versions.item_count > 0:
		visible = true
		$Versions.select(0)
		_on_versions_item_selected(0)
	else:
		if DirAccess.dir_exists_absolute(folder_path):
			DirAccess.remove_absolute(folder_path)

# Version Selector
func _on_versions_item_selected(index: int) -> void:
	selected_version = index



# Hover VFX
func _on_mouse_entered() -> void:
	$Hover.visible = true
	$"Game Label".visible = true
func _on_mouse_exited() -> void:
	$Hover.visible = false
	$"Game Label".visible = false


# get rid of the stoopid Main.file_type just putting ".exe" would be more readable
