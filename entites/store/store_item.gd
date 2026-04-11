@icon("res://editor_icons/shop_item.png")
extends TextureButton
@export var type : String



# Hover Effects
func _on_mouse_entered() -> void:
	$Hover.visible = true
	$"Game Label".visible = true
func _on_mouse_exited() -> void:
	$Hover.visible = false
	$"Game Label".visible = false



func _on_pressed() -> void:
	$"../../../../../../Store Pages".visible = true
	match type:
		"FNAB": $"../../../../../../Store Pages/FNAB".visible = true
		"FNAB2": pass
		"VegAlpha": pass
		"VegRegrown": pass


## Dev Notes
# Resolutions for game covers are 600x900 for High Res and 60x90 for Low Res.
# Generally: set the cover texture mode to Linear for High Res and Nearest for Low Res.


# moved store pages node to be under the store button for cleaner organization 
# in the editor just name 
# also some point im moving most of the buttons to one script thats so many buttons that just have one function
