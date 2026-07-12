extends TextureButton

@export var menu : Panel 
@export var index : int



func _ready() -> void:
	texture_normal = menu.default_avatars[index]

func _on_pressed() -> void:
	Main.launcher_data.avatar = index
	menu.update_avatar()
	$Tap.play()
