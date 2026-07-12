extends TextureButton

@export var menu : Panel 
@export var index : int



func _ready() -> void:
	texture_normal = menu.default_avatars[index]

func _on_pressed() -> void:
	Main.launcher_data.avatar = index
	menu.update_avatar()
	$Tap.play()


func _on_mouse_entered() -> void:
	self_modulate = Color(0.626, 0.626, 0.626, 1.0)
func _on_mouse_exited() -> void:
	self_modulate = Color(1.0, 1.0, 1.0, 1.0)


func _on_button_down() -> void:
	self_modulate = Color(0.42, 0.42, 0.42, 1.0)
func _on_button_up() -> void:
	self_modulate = Color(1.0, 1.0, 1.0, 1.0)
