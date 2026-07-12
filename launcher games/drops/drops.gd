extends Panel
@export var drops : Array[Texture2D]
var can_scroll : bool = true



func _ready() -> void:
	for i in drops:
		var new_drop = TextureRect.new()
		new_drop.texture = i
		new_drop.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		new_drop.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		new_drop.custom_minimum_size = Vector2(108, 189)
		$ScrollContainer/VBoxContainer.add_child(new_drop)

func _input(_event: InputEvent) -> void:
	if !visible:
		return
	
	if Input.is_action_just_pressed("scroll_up"):
		if can_scroll == true:
			var tween = create_tween()
			tween.tween_property($ScrollContainer, "scroll_vertical", $ScrollContainer.scroll_vertical - 189, 0.2)
			can_scroll = false
			await get_tree().create_timer(0.2).timeout
			can_scroll = true
	if Input.is_action_just_pressed("scroll_down"):
		if can_scroll == true:
			var tween = create_tween()
			tween.tween_property($ScrollContainer, "scroll_vertical", $ScrollContainer.scroll_vertical + 189, 0.2)
			can_scroll = false
			await get_tree().create_timer(0.2).timeout
			can_scroll = true
