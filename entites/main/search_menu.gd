@icon("res://editor_icons/shop_item.png")
extends Control
var matches : Array = []
@export var items : GridContainer



func _on_search_bar_text_changed(new_text: String) -> void:
	new_text = new_text.to_lower()
	
	if new_text == "":
		for i in items.get_children():
			i.show()
		return
	matches.clear()
	
	for i in items.get_children():
		if new_text in i.name.to_lower():
			matches.append(i)
	
	
	
	for i in items.get_children():
		if i in matches:
			i.show()
		else:
			i.hide()
