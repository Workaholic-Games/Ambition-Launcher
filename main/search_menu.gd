@icon("res://editor_icons/shop_item.png")
extends Control
var matches : Array = []
@export var items : GridContainer
@export var search : String



# Searchbar Functionality
func _on_search_bar_text_changed(new_text: String) -> void:
	if search == "library":
		library_search(new_text)
	
	elif search == "store":
		store_search(new_text)

func library_search(text : String):
	text = text.to_lower()
	
	if text == "":
		for i in items.get_children():
			if i.installed == true:
				i.show()
			else:
				i.hide()
		return
	matches.clear()
	
	for i in items.get_children():
		if text in i.name.to_lower():
			matches.append(i)
	
	for i in items.get_children():
		if i in matches:
			if i.installed == true:
				i.show()
			else:
				i.hide()
		else:
			i.hide()

func store_search(text : String):
	text = text.to_lower()
	
	if text == "":
		for i in items.get_children():
			i.show()
		return
	matches.clear()
	
	for i in items.get_children():
		if text in i.name.to_lower():
			matches.append(i)
	
	for i in items.get_children():
		if i in matches:
			i.show()
		else:
			i.hide()
