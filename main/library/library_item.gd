extends TextureButton

@export var game : GameData
@export var menu : Control



func _ready() -> void:
	$"Game Label".text = game.name
	$"Game Label".add_theme_font_size_override("font_size", game.font_size)
	
	if Main.launcher_data.last_played == self.name:
		get_parent().call_deferred("move_child", self, 0)

func _on_mouse_entered() -> void:
	$Hover.visible = true
	$"Game Label".visible = true
func _on_mouse_exited() -> void:
	$Hover.visible = false
	$"Game Label".visible = false

func _on_pressed() -> void:
	get_parent().move_child(self, 0)
	menu.show()
