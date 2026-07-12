extends Node



# Just a bunch of UI hiding then turning the Correct UI Visible.
func _on_library_pressed() -> void:
	$"../../Tap".play()
	hide_ui()
	$"../../Library".visible = true
func _on_store_pressed() -> void:
	$"../../Tap".play()
	hide_ui()
	for node in get_tree().get_nodes_in_group("Collision"):
		node.set_deferred("disabled", false)
	$"../../Store".visible = true
func _on_community_pressed() -> void:
	$"../../Tap".play()
	hide_ui()
	$"../../Community".visible = true
func _on_changelog_pressed() -> void:
	$"../../Tap".play()
	hide_ui()
	$"../../Changelog".visible = true
func _on_developers_pressed() -> void:
	$"../../Tap".play()
	hide_ui()
	$"../../Developers".visible = true
func _on_settings_pressed() -> void:
	$"../../Tap".play()
	hide_ui()
	$"../../Settings".visible = true
func _on_quit_launcher_pressed() -> void:
	$"../../Tap".play()
	hide_ui()
	$"../../Quit".visible = true
func _on_avatar_pressed() -> void:
	$"../../Tap".play()
	#hide_ui()
	$"../../User".visible = true
	$"../../Avatar".visible = false
# UI hide function
func hide_ui():
	$"../../Library".visible = false
	$"../../Store".visible = false
	$"../../Store Pages".visible = false
	$"../../Community".visible = false
	$"../../Changelog".visible = false
	$"../../Developers".visible = false
	$"../../Settings".visible = false
	$"../../Quit".visible = false
	$"../../User".visible = false
	$"../../Avatar".visible = true
	for page in $"../../Store Pages".get_children():
		page.visible = false
	for node in get_tree().get_nodes_in_group("Collision"):
		node.set_deferred("disabled", true)
