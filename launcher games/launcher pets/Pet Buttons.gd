extends Node

func button_pressed():
	if Main.launcher_data.pet_spawned == false:
		$"../../CharacterBody2D".position = Vector2(355, 34)
		$"../../CharacterBody2D".process_mode =Node.PROCESS_MODE_INHERIT
		$"../../CharacterBody2D".visible = true
		$"../../WalkTimer".start()
		$"../../JumpTimer".start()
		Main.launcher_data.pet_spawned = true
		
	else:
		
		$"../../CharacterBody2D".visible = false
		$"../../CharacterBody2D".process_mode =Node.PROCESS_MODE_DISABLED
		$"../../WalkTimer".stop()
		$"../../JumpTimer".stop()
		Main.launcher_data.pet_spawned = false


func _on_slime_button_pressed() -> void:
	button_pressed()


func _on_square_button_pressed() -> void:
	button_pressed()

func _on_snail_button_pressed() -> void:
	button_pressed()
