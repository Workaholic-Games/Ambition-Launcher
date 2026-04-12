extends Button

@onready var store_pages: Control = $".."


func _on_pressed() -> void:
	store_pages.visible = false
