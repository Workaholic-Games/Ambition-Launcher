extends Control
var words = [
	"ea",
	"ee"]

## might need to add a dialogue speed slider
## I wanna add it so if you attempt anything sus you get rejected

# make collision shapes turn invis when you switch tabs



func _on_input_text_submitted(new_text: String) -> void:
	var text = new_text.to_lower()
	
	if text.contains("hi"): $Response.text = "whats good my g"
	
	
	var voices = DisplayServer.tts_get_voices_for_language("en") # Select the first English voice
	DisplayServer.tts_stop()
	DisplayServer.tts_speak($Response.text, voices[1], 50, 1.6, 1.0)
	yap()
	$Response.visible = true


func _on_input_text_changed(new_text: String) -> void:
	$Input.modulate = Color.WHITE
	var text = new_text.to_lower()
	for word in words:
		if text.contains(word):
			$Input.modulate = Color.CYAN



func yap():
	$Input.clear()
	$Response.visible_ratio = 0.0
	$Response.visible_characters = 0
	$"Yap Timer".start()
	$Input.release_focus()



func _on_yap_timer_timeout() -> void:
	if $Response.visible_ratio != 1.0:
		$Response.visible_characters += 1
	else:
		$"Yap Timer".stop()



func _on_dell_toggled(toggled_on: bool) -> void:
	match toggled_on:
		true:
			$BG.visible = true
			$SubViewportContainer.visible = true
			$Input.visible = true
			$Response.visible = true
		false:
			$BG.visible = false
			$SubViewportContainer.visible = false
			$Input.visible = false
			$Response.visible = false
