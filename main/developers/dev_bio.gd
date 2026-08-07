extends Panel
class_name DevBio
@export var avatar : Texture2D
@export var dev_name : String
@export_multiline() var bio : String
@export var rank : String
@export var pronoun : String
@export var featured : Array[GameData]
@export var featured_page : Array[StorePage]

var featured_item_scene : Resource = load("res://main/store/store_item.tscn")



func _ready() -> void:
	$Portrait.texture = avatar
	$Info/Name.text = dev_name
	$Info/Rank.text = rank
	$Info/Pronoun.text = pronoun
	$Description.text = bio
	
	if featured.size() > 0:
		for i in featured.size():
			print(i)
			var new_featured = featured_item_scene.instantiate()
			new_featured.game = featured[i]
			$GridContainer.add_child(new_featured)
			new_featured.page = featured_page[i]
	else:
		$"Featured Games".hide()

func _on_close_pressed() -> void:
	hide()
