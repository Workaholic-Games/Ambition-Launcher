extends TextureButton

func _on_toggled(toggled_on: bool) -> void:
	$"../../../Tap".play()
	if toggled_on:
		$"GridContainer".visible = true
		$Size.visible = true
		
	else:
		$"GridContainer".visible = false
		$Size.visible = false
