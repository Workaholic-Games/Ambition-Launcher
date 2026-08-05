extends Control
@onready var content : HBoxContainer = $ScrollContainer/HBoxContainer
@export var page : StorePage
var preview_min : int = 1
var preview_max : int = 0
var preview_current: int = 1


func tween_ui(object : Control, property : String, value, duration : float = 1.0):
	var tween = create_tween()
	tween.tween_property(object, property, value, duration)


func _ready() -> void:
	for v in page.game.videos.size():
		var new_video = load("res://main/store_pages/video_player.tscn").instantiate()
		new_video.video = page.game.videos[v]
		content.add_child(new_video)
		preview_max += 1
	
	for image in page.game.images.size():
		var thumbnail = TextureRect.new()
		thumbnail.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		thumbnail.stretch_mode = TextureRect.STRETCH_SCALE
		thumbnail.custom_minimum_size = Vector2(384.0, 216.0)
		thumbnail.custom_maximum_size = Vector2(384.0, 216.0)
		thumbnail.texture = page.game.images.get(image)
		content.add_child(thumbnail)
		preview_max += 1


func _on_left_button_pressed() -> void:
	if preview_current > preview_min:
		tween_ui(content, "offset_transform_position", Vector2(content.offset_transform_position.x + 384.0, content.position.y), 0.1)
		preview_current -= 1

func _on_right_button_pressed() -> void:
	if preview_current < preview_max:
		tween_ui(content, "offset_transform_position", Vector2(content.offset_transform_position.x - 384.0, content.position.y), 0.1)
		preview_current += 1
