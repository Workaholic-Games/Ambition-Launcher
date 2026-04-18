extends TextureButton
var spawned = false


func _on_pressed() -> void:
	
	if spawned == false:
		$"../CharacterBody2D".process_mode =Node.PROCESS_MODE_INHERIT
		$"../CharacterBody2D".visible = true
		$"../WalkTimer".start()
		$"../JumpTimer".start()
		spawned = true
	else:
		$"../CharacterBody2D".process_mode =Node.PROCESS_MODE_DISABLED
		$"../CharacterBody2D".visible = false
		$"../CharacterBody2D".position = Vector2(355.0, 34)
		spawned = false
