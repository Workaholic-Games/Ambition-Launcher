extends Button



func _on_pressed() -> void:
	$"..".visible = false
	$Tap.play()
