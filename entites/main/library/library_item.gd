extends TextureButton
@export var game_name : String
@export var game_file_display_names : PackedStringArray
@export var version_file_names_windows : PackedStringArray
@export var version_file_names_mac : PackedStringArray
@export var version_file_names_linux : PackedStringArray
var selected_version : int = 0


# make only versions you have installed appear
# add checking if theres a new version of whatever app and a respective install button


func _ready() -> void:
	$"Game Label".text = game_name
	
	if Main.launcher_data.last_played == self.name:
		get_parent().call_deferred("move_child", self, 0)
		#get_parent().move_child(self, 0)
	
	for version: String in game_file_display_names:
		$Versions.add_item(version)
	
	check()



# Boot up version of game
func _on_pressed() -> void:
	var absolute_path = ProjectSettings.globalize_path("user://Ambition_Installer_Windows.exe")
	match Main.operating_system:
		"Windows":
			absolute_path = ProjectSettings.globalize_path("user://" + version_file_names_windows.get(selected_version) + ".exe")
			OS.shell_open(absolute_path)
		"macOS":
			absolute_path = ProjectSettings.globalize_path("user://" + version_file_names_mac.get(selected_version) + ".app")
			OS.shell_open(absolute_path)
	
	
	Main.launcher_data.last_played = self.name
	get_parent().move_child(self, 0)



# Uninstall Version of game
func _on_uninstall_pressed() -> void:
	match Main.operating_system:
		"Windows":
			DirAccess.remove_absolute("user://" + version_file_names_windows.get(selected_version) + ".exe")
		"macOS":
			DirAccess.remove_absolute("user://" + version_file_names_windows.get(selected_version) + ".app")
	check()


# Check if any versions of game exist
func check():
	visible = false
	match Main.operating_system:
		"Windows":
			for i in $Versions.item_count:
				if FileAccess.file_exists("user://" + version_file_names_windows.get(i) + ".exe"):
					visible = true
					$Versions.select(i)
					$Versions.emit_signal("item_selected", i)
					break
		"macOS":
			for i in $Versions.item_count:
				if DirAccess.dir_exists_absolute("user://" + version_file_names_mac.get(i) + ".app"):
					visible = true
					$Versions.select(i)
					$Versions.emit_signal("item_selected", i)
					break


# demo is busted yay


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
