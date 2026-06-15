extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "Hello " + Main.launcher_data.username


func _on_change_avatar_pressed() -> void:
	$"Avatar Selection".visible = true
	pass # Replace with function body.
