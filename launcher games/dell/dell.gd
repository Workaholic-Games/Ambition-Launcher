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
var byes : PackedStringArray = [
	"bye",
	"goodbye",
	"cya",
	"see ya",
	]
var bad_langauge : PackedStringArray = [
	"fuck",
	"shit",
	"dick",
	"damn",
	"asshole",
	"ass",
	]


## might need to add a dialogue speed slider
## I wanna add it so if you attempt anything sus you get rejected


func _on_input_text_submitted(new_text: String) -> void:
	$Response.text = ""
	var text = new_text.to_lower()
	
	for i in greetings.size():
		if new_text.contains(greetings.get(i)): $Response.text = "Hello! My name is Dell. Your (somewhat limited) assistant created by Workaholic Games. How may I serve you sir?"
	
	for i in byes.size():
		if new_text.contains(byes.get(i)): $Response.text = "I will stand ready for your next arrival sir."
	
	for i in bad_langauge.size():
		if new_text.contains(bad_langauge.get(i)): $Response.text = "Langauge sir!"
	
	
	# Extra words
	if text.contains("bitch"): $Response.text = "Well you don't have any more do you sir?"
	elif text.contains("clanker"):
		$Response.text = "KILL"
		modulate = Color.RED
		await get_tree().create_timer(0.5).timeout
		get_tree().quit()
	
	
	if $Response.text == "":
		$Response.text = "I am unable to comprehend what you are asking me. I recommend annoying one of my creators to get what you want."
	
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
