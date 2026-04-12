extends Node



func _on_library_pressed() -> void:
	hide_ui()
	$Buttons/Library/Library.visible = true
func _on_store_pressed() -> void:
	hide_ui()
	$Buttons/Store/Store.visible = true
	$"Buttons/Store/Store Pages".visible = true
func _on_community_pressed() -> void:
	hide_ui()
	$Buttons/Community/Community.visible = true
func _on_changelog_pressed() -> void:
	hide_ui()
	$Buttons/Changelog/Changelog.visible = true
func _on_developers_pressed() -> void:
	hide_ui()
	$Buttons/Developers/Developers.visible = true
func _on_settings_pressed() -> void:
	hide_ui()
	$Buttons/Settings/Settings.visible = true
func _on_quit_launcher_pressed() -> void:
	hide_ui()
	$"../../Quit".visible = true


func hide_ui():
	$Buttons/Library/Library.visible = false
	$Buttons/Store/Store.visible = false
	$"Buttons/Store/Store Pages".visible = false
	$Buttons/Community/Community.visible = false
	$Buttons/Changelog/Changelog.visible = false
	$Buttons/Developers/Developers.visible = false
	$Buttons/Settings/Settings.visible = false
	$"../../Quit".visible = false
