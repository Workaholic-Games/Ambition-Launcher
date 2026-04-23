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
	"hot",
	]
var drugs : PackedStringArray = [
	"crack",
	"cocaine",
	"meth",
	"coke",
	"weed",
	"mj",
	"tobacoo",
]
var master_list : PackedStringArray = [
	"hi",
	"hello",
	"hey",
	"yo",
	"wsg",
	"sup",
	"good morning",
	"good evening",
	"bye",
	"goodbye",
	"cya",
	"see ya",
	"fuck",
	"shit",
	"dick",
	"damn",
	"asshole",
	"ass",
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
	"bitch",
	"open game",
	"jonathan",
	"bulba",
	"help",
	"clanker",
	"hot",
	"crack",
	"cocaine",
	"meth",
	"coke",
	"weed",
	"mj",
	"tobacoo",
	"jarvis",
	"fnab3",
	"scaryhead",
	"project u",
	"vegetable game",
	]



## might need to add a dialogue speed slider
## I wanna add it so if you attempt anything sus you get rejected

# make collision shapes turn invis when you switch tabs

func _on_input_text_submitted(new_text: String) -> void:
	$Response.text = ""
	var text = new_text.to_lower()
	
	for i in greetings.size():
		if text.contains(greetings.get(i)): $Response.text = "Hello! My name is Dell. Your (somewhat limited) assistant created by Workaholic Games. How may I serve you sir?"
	
	for i in byes.size():
		if text.contains(byes.get(i)): $Response.text = "I will stand ready for your next arrival sir."
	
	for i in bad_langauge.size():
		if text.contains(bad_langauge.get(i)): $Response.text = "I'm going to contact HR."
	
	for i in sus.size():
		if text.contains(sus.get(i)): $Response.text = "You really thought you had a chance? Am I really that ugly sir?"
	
	for i in drugs.size():
		if text.contains(sus.get(i)): $Response.text = "As of now I am not allowed to give you anything like that
		sir."
	
	
	
	# Extra words
	if text.contains("bitch"): $Response.text = "Well you don't have any more do you sir?"
	
	elif text.contains("open game"): $Response.text = "To open the game you must click on the library button on the top left corner of your screen. Then if you have installed it, click on the games icon. Have fun!"
	elif text.contains("clanker"):
		$Response.text = "KILL"
		modulate = Color.RED
		await get_tree().create_timer(0.5).timeout
		get_tree().quit()
	elif text.contains("jonathan"): $Response.text = "Jonathan is one of my two creators. However, he was more hands off in my creation"
	elif text.contains("bulba"): $Response.text = "Bulba is one of my two creators. He was the one creating my inner systems."
	elif text.contains("help"): $Response.text = "Please be more specific sir."
	elif text.contains("jarvis"): $Response.text = "I am not jarvis sir. My name is Dell."
	elif text.contains("fnab3"): $Response.text = "He's not ready yet."
	elif text.contains("scaryhead"): $Response.text = "L Mortisha."
	elif text.contains("project u"): $Response.text = "You will not be on the road yet..."
	elif text.contains("vegetable game"): $Response.text = "I'm sure he will release the game eventually. Right?"
	
	
	
	if $Response.text == "":
		$Response.text = "I am unable to comprehend what you are asking me. I recommend annoying one of my creators to get what you want."
	
	var voices = DisplayServer.tts_get_voices_for_language("en") # Select the first English voice
	DisplayServer.tts_stop()
	DisplayServer.tts_speak($Response.text, voices[1], 50, 1.6, 1.0)
	yap()
	$Response.visible = true
	$Response.size = Vector2(52.0, 0)



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





#You agree that Jonathan has mega aura and surpreme rizz and gets all the huzz.
#You agree that Bulba is jacked gigachad with tuff looksmaxing aura level 67.


func _on_input_text_changed(new_text: String) -> void:
	$Input.modulate = Color.WHITE
	var text = new_text.to_lower()
	
	for i in master_list.size():
		if text.contains(master_list.get(i)): $Input.modulate = Color.CYAN


## considering a bunch of technical changes to how dell works to make this all a bit cleaner


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
