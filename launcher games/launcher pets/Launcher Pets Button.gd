extends TextureButton



func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		print("toggled on")
		$"GridContainer".visible = true
		$Size.visible = true
		$"../CharacterBody2D".process_mode =Node.PROCESS_MODE_DISABLED
	else:
		print("toggled off")
		$"GridContainer".visible = false
		$Size.visible = false
