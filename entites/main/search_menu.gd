@icon("res://editor_icons/shop_item.png")
extends Control
var matches : Array = []
@export var items : GridContainer

# Searchbar Functionality
func _on_search_bar_text_changed(new_text: String) -> void:
	new_text = new_text.to_lower()
	
	if new_text == "":
		for i in items.get_children():
			for j in i.get_children():
				for k in j.get_children():
					k.show()
		return
	matches.clear()
	
	for i in items.get_children():
		for j in i.get_children():
			for k in j.get_children():
				if new_text in k.name.to_lower():
					matches.append(k)
	
	for i in items.get_children():
		for j in i.get_children():
			for k in j.get_children():
				if k in matches:
					k.show()
				else:
					k.hide()
