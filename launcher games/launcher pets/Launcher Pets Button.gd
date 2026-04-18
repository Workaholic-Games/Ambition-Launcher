extends TextureButton

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		print("toggled on")
		$"Square Button".visible = true
		$"Slime Button".visible = true
		$"../CharacterBody2D".process_mode =Node.PROCESS_MODE_DISABLED
	else:
		print("toggled off")
		$"Slime Button".visible = false
		$"Square Button".visible = false
		$"../CharacterBody2D".process_mode =Node.PROCESS_MODE_DISABLED
		$"../CharacterBody2D".visible = false
		$"../WalkTimer".stop()
		$"../JumpTimer".stop()
		Main.launcher_data.pet_spawned = false
