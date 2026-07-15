extends Panel
@export var drops : Array[Texture2D]
@export var ads : Array[VideoStreamTheora]
var can_scroll : bool = true
var playing_ad : bool = false
var can_skip_ad : bool = true
var on_drops : bool = false

func _ready() -> void:
	for i in drops:
		var new_drop = TextureRect.new()
		new_drop.texture = i
		new_drop.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		new_drop.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		new_drop.custom_minimum_size = Vector2(108, 189)
		$ScrollContainer/VBoxContainer.add_child(new_drop)



func _input(_event: InputEvent) -> void:
	if visible == false:
		return
	
	if Input.is_action_just_pressed("scroll_up"):
		if playing_ad == true and can_skip_ad == true:
			playing_ad = false
			$Ads.stop()
			$Ads.hide()
		
		if can_scroll == true and playing_ad == false and can_skip_ad == true:
			var tween = create_tween()
			tween.tween_property($ScrollContainer, "scroll_vertical", $ScrollContainer.scroll_vertical - 189, 0.2)
			can_scroll = false
			ad_check()
			await get_tree().create_timer(0.2).timeout
			can_scroll = true
	if Input.is_action_just_pressed("scroll_down"):
		if playing_ad == true and can_skip_ad == true:
			playing_ad = false
			$Ads.stop()
			$Ads.hide()
		
		if can_scroll == true and playing_ad == false and can_skip_ad == true:
			var tween = create_tween()
			tween.tween_property($ScrollContainer, "scroll_vertical", $ScrollContainer.scroll_vertical + 189, 0.2)
			can_scroll = false
			ad_check()
			await get_tree().create_timer(0.2).timeout
			can_scroll = true

func ad_check():
	var ad = randi_range(0, 8)
	if ad == 8:
		$Ads.stream = ads.pick_random()
		$Ads.play()
		$Ads.show()
		playing_ad = true
		can_skip_ad = false
		$Ads.stream_position = 0.01
		$Ads/AD_Time.step = $Ads.get_stream_length() * 0.0001
		$Ads/Skip.hide()
		
		await get_tree().create_timer(5.0).timeout
		can_skip_ad = true

func _on_ads_finished() -> void:
	$Ads.stop()
	$Ads.hide()
	playing_ad = false

func _on_skip_pressed() -> void:
	$Ads.stop()
	$Ads.hide()
	playing_ad = false

func _on_drops_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		show()
		$"../../Tap".play()
	else:
		hide()


func _on_visibility_changed() -> void:
	if visible == false:
		$Ads.paused = true
	else:
		$Ads.paused = false



func _physics_process(_delta: float) -> void:
	if playing_ad == true:
		$Ads/AD_Time.value = $Ads.stream_position


func _on_ad_time_value_changed(value: float) -> void:
	if value == 5:
		$Ads/Skip.show()
		
