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
var sus : PackedStringArray = [
	"babe",
	"baby",
	"sweetheart",
	"darling",
	"my love",
	"dear",
	"gorgeous",
	"beautiful",
	"stunning",
	"doll",
	"honey",
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
		if new_text.contains(bad_langauge.get(i)): $Response.text = "I'm going to contact HR."
	
	for i in sus.size():
		if new_text.contains(sus.get(i)): $Response.text = "You really thought you had a chance? Am I really that ugly?"
	
	
	# Extra words
	if text.contains("bitch"): $Response.text = "Well you don't have any more do you sir?"
	
	elif text.contains("open game"): $Response.text = "To open the game you must click on the library button on the top left corner of your screen. Then if you have installed it, click on the games icon. Have fun!"
	elif text.contains("clanker"):
		$Response.text = "KILL"
		modulate = Color.RED
		await get_tree().create_timer(0.5).timeout
		get_tree().quit()
	elif text.contains("adam"): $Response.text = "He's such a big back chud for real for real."
	elif text.contains("mark"): $Response.text = "Mark? I didn't accidently step on him did I? I didn't see him down there."
	elif text.contains("robert"): $Response.text = "Who's robert?"
	elif text.contains("sawyer"): $Response.text = "Sawyer..."
	elif text.contains("gavin"): $Response.text = "Oh don't remind me of his fish smell."
	elif text.contains("claire"): $Response.text = "Who?"
	elif text.contains("charlie"): $Response.text = "I'm gonna gun that animal down with my hunting rifle."
	elif text.contains("jonathan"): $Response.text = "Oh jonathan. He's on of my creators... ummm... Can we switch the topic please?"
	elif text.contains("bulba"): $Response.text = "Oh bulba. He's on of my creators... ummm... Can we switch the topic please?"
	
	
	if $Response.text == "":
		$Response.text = "I am unable to comprehend what you are asking me. I recommend annoying one of my creators to get what you want."
	
	
	var voices = DisplayServer.tts_get_voices_for_language("en")
	var voice_id = voices[1] # Select the first English voice
	DisplayServer.tts_speak($Response.text, voice_id, 50, 1.6, 1.0)
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





#You agree that Jonathan has mega aura and surpreme rizz and gets all the huzz.
#You agree that Bulba is jacked gigachad with tuff looksmaxing aura level 67.
