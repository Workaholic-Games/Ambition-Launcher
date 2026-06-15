extends TextureButton

@export var avatar : Texture = null
@export var menu : Panel 
@export var index : int
func _on_pressed() -> void:
	Main.launcher_data.avatar = menu.default_avatars[index]
