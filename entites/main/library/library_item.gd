extends TextureButton
@export var game_name : String
@export var game_file_display_names : PackedStringArray
@export var game_file_names : PackedStringArray
var selected_version : int = 0
var os_name : String = "_Windows"



func _ready() -> void:
	$"Game Label".text = game_name
	
	if Main.launcher_data.last_played == self.name:
		get_parent().call_deferred("move_child", self, 0)
		#get_parent().move_child(self, 0)
	
	for version: String in game_file_display_names:
		$Versions.add_item(version)
	
	match Main.operating_system:
		"Windows": os_name = "_Windows"
		"macOS": os_name = "_Mac"
	
	check()



# Boot up version of game
func _on_pressed() -> void:
	match Main.operating_system:
		"Windows":
			var absolute_path = ProjectSettings.globalize_path("user://" + game_file_names.get(selected_version) + os_name + Main.file_type)
			OS.shell_open(absolute_path)
		"macOS":
			var absolute_path = ProjectSettings.globalize_path(game_file_names.get(selected_version) + ".app")
			OS.shell_open("file://" + absolute_path)
	
	
	
	Main.launcher_data.last_played = self.name
	get_parent().move_child(self, 0)



# Uninstall Version of game
func _on_uninstall_pressed() -> void:
	DirAccess.remove_absolute("user://" + game_file_names.get(selected_version) + os_name + Main.file_type)
	check()


# Check if any versions of game exist
func check():
	visible = false
	for i in $Versions.item_count:
		if FileAccess.file_exists("user://" + game_file_names.get(i) + os_name + Main.file_type):
			visible = true
			$Versions.select(i)
			$Versions.emit_signal("item_selected", i)
			break



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
