extends MarginContainer
@export var title : String
@export var image : Texture



func _ready() -> void:
	name = title
	$VBoxContainer/Title.text = title
	$VBoxContainer/Art.texture = image
