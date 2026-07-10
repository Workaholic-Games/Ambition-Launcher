extends Control
var count = 0
var count2 = 0


func _on_featured_art_pressed() -> void:
	hide_community()
	$Featured.visible = true
func _on_install_mods_pressed() -> void:
	count += 1
	if count == 1000:
		$Lock.hide()
	#hide_community()
func _on_modding_guide_pressed() -> void:
	count2 += 1
	if count2 == 1000:
		$Lock2.hide()
	#hide_community()



func hide_community():
	$Featured.visible = false
