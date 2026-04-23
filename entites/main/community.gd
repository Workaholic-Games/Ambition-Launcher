extends Control



func _on_featured_art_pressed() -> void:
	hide_community()
	$Featured.visible = true
func _on_install_mods_pressed() -> void:
	hide_community()
func _on_modding_guide_pressed() -> void:
	hide_community()



func hide_community():
	$Featured.visible = false
