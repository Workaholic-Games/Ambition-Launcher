extends Panel
class_name DevBio
@export var avatar : Texture2D
@export var dev_name : String
@export var rank : String
@export var pronoun : String
@export var featured : Array[StorePage]
@export var featured_covers : Array[Texture2D]
@export var featured_names : Array[String]
@export var featured_font_sizes : Array[int]
var featured_item_scene : Resource = load("res://main/store_item.tscn")



func _ready() -> void:
	$Portrait.texture = avatar
	$Info/Name.text = dev_name
	$Info/Rank.text = rank
	$Info/Pronoun.text = pronoun
	
	for i in featured.size():
		print(i)
		var new_featured = featured_item_scene.instantiate()
		new_featured.cover = featured_covers[i]
		new_featured.game_name = featured_names[i]
		new_featured.font_size = featured_font_sizes[i]
		new_featured.from_dev = true
		$GridContainer.add_child(new_featured)
		new_featured.page = featured[i]


func _on_close_pressed() -> void:
	hide()
