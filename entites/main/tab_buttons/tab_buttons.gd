extends Node



# Just a bunch of UI hiding then turning the Correct UI Visible.
func _on_library_pressed() -> void:
	hide_ui()
	$"../../Library".visible = true
func _on_store_pressed() -> void:
	hide_ui()
	$"../../Store".visible = true
	$"../../Store/Area/GridContainer/Five Nights at Bulbas (FNAB)/Line/StaticBody2D/CollisionShape2D".disabled = false
	$"../../Store/Area/GridContainer/Other (Bitcoin Miner)/Line/StaticBody2D/CollisionShape2D".disabled = false
func _on_community_pressed() -> void:
	hide_ui()
	$"../../Community".visible = true
func _on_changelog_pressed() -> void:
	hide_ui()
	$"../../Changelog".visible = true
func _on_developers_pressed() -> void:
	hide_ui()
	$"../../Developers".visible = true
func _on_settings_pressed() -> void:
	hide_ui()
	$"../../Settings".visible = true
func _on_quit_launcher_pressed() -> void:
	hide_ui()
	$"../../Quit".visible = true



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
	$"../../Store/Area/GridContainer/Five Nights at Bulbas (FNAB)/Line/StaticBody2D/CollisionShape2D".disabled = true
	$"../../Store/Area/GridContainer/Other (Bitcoin Miner)/Line/StaticBody2D/CollisionShape2D".disabled = true
	for i in $"../../Store Pages".get_children():
		i.visible = false
