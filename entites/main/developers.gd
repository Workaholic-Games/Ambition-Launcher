extends Control



func _on_close_pressed() -> void:
	$"Bulba Bio".visible = false
	$"Jonathan Bio".visible = false
	$"Sawyer Bio".visible = false



func _on_bulba_pressed() -> void:
	$"Bulba Bio".visible = true

func _on_jonathan_pressed() -> void:
	$"Jonathan Bio".visible = true

func _on_sawyer_pressed() -> void:
	$"Sawyer Bio".visible = true
