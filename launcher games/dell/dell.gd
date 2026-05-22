extends Control



func _on_dell_toggled(toggled_on: bool) -> void:
	match toggled_on:
		true:
			$BG.visible = true
			$SubViewportContainer.visible = true
		false:
			$BG.visible = false
			$SubViewportContainer.visible = false
