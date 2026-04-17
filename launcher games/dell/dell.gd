extends Control
var greetings : PackedStringArray = [
	"hi",
	"hello",
	"hey",
	"yo",
	"wsg",
	"sup",
	"good morning",
	"good evening",
	]



## might need to add a dialogue speed slider
## I wanna add it so if you attempt anything sus you get rejected


func _on_input_text_submitted(new_text: String) -> void:
	var text = new_text.to_lower()
	
	if greetings.has(text):
		$Response.text = "Hi."
	
	
	else: $Response.text = "I am unable to comprehend what you are trying to ask me. I recommend annoying one of my creators to get what you want."
		
		
	
	yap()



func yap():
	$Input.clear()
	$Response.visible_ratio = 0.0
	$Response.visible_characters = 0
	$"Yap Timer".start()



func _on_yap_timer_timeout() -> void:
	if $Response.visible_ratio != 1.0:
		$Response.visible_characters += 1
	else:
		$"Yap Timer".stop()
