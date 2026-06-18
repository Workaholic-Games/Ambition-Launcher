extends Panel

var is_dragged : bool = false
var is_finished : bool = false
var started : bool = false
var video : VideoStream



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VideoStreamPlayer.stream = video
	$VideoStreamPlayer.play()
	$VideoStreamPlayer.paused = true
	$VideoStreamPlayer.stream_position = 0.01
	$"Playback Position".max_value = $VideoStreamPlayer.get_stream_length()
	$"Playback Position".step = $VideoStreamPlayer.get_stream_length() * 0.0001
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_dragged == false:
		$"Playback Position".value = $VideoStreamPlayer.stream_position
	else:
		$VideoStreamPlayer.stream_position = $"Playback Position".value
	pass


func _on_start_button_pressed() -> void:
	if is_finished == true:
		$VideoStreamPlayer.play()
	$VideoStreamPlayer.paused = false
	$"Start Button".hide()
	started = true
	pass # Replace with function body.


func _on_playback_position_drag_started() -> void:
	is_dragged = true
	pass # Replace with function body.


func _on_playback_position_drag_ended(_value_changed: bool) -> void:
	is_dragged = false
	pass # Replace with function body.


func _on_play_pause_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		$VideoStreamPlayer.paused = true
	else:
		$VideoStreamPlayer.paused = false
	pass # Replace with function body.


func _on_video_stream_player_finished() -> void:
	is_finished = true
	$"Start Button".show()
	$"Start Button".texture_normal = load("res://main/store_pages/videos/assets/loop.tres")
	$"Start Button".texture_hover = load("res://main/store_pages/videos/assets/loop_hover.tres")
	pass # Replace with function body.


func _on_volume_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		$"Volume Toggle".text = "↓"
		$Volume.show()
	else:
		$"Volume Toggle".text = "↑"
		$Volume.hide()
	pass # Replace with function body.


func _on_volume_value_changed(value: float) -> void:
	$VideoStreamPlayer.volume_db = value
	if value == -20:
		$VideoStreamPlayer.volume = 0
	pass # Replace with function body.


func _on_video_stream_player_mouse_entered() -> void:
	if started == true:
		$"Playback Position".show()
		$Play_Pause.show()
		$"Volume Toggle".show()

func _on_video_stream_player_mouse_exited() -> void:
	$"Playback Position".hide()
	$Play_Pause.hide()
	$"Volume Toggle".hide()


func _on_playback_position_mouse_entered() -> void:
	$"Playback Position".show()
	$Play_Pause.show()
	$"Volume Toggle".show()


func _on_play_pause_mouse_entered() -> void:
	$"Playback Position".show()
	$Play_Pause.show()
	$"Volume Toggle".show()

func _on_volume_toggle_mouse_entered() -> void:
	$"Playback Position".show()
	$Play_Pause.show()
	$"Volume Toggle".show()

func _on_volume_mouse_entered() -> void:
	$"Playback Position".show()
	$Play_Pause.show()
	$"Volume Toggle".show()
