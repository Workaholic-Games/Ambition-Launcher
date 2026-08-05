@icon("res://editor_icons/shop_icon.png")
extends TextureButton
@export var page : StorePage
@export var game : GameData



func _ready() -> void:
	texture_normal = game.cover
	$"Game Label".text = game.name
	$"Game Label".add_theme_font_size_override("font_size", game.font_size)

# Hover Effects
func _on_mouse_entered() -> void:
	$Hover.visible = true
	$"Game Label".visible = true
func _on_mouse_exited() -> void:
	$Hover.visible = false
	$"Game Label".visible = false

func _on_pressed() -> void:
	page.show()
	$Tap.play()


## Dev Notes
# Resolutions for game covers are 600x900 for High Res and 60x90 for Low Res.
# Generally: set the cover texture mode to Linear for High Res and Nearest for Low Res.
