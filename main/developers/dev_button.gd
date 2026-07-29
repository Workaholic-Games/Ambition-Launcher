extends Button
@export var bio : DevBio
@export var avatar : Texture2D



func _ready() -> void:
	$Avatar.texture = avatar

func _on_pressed() -> void:
	bio.show()
