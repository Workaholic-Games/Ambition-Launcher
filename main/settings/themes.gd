extends Control
@export var splashes : Array[String]

var themes: Dictionary[String, Theme] = {
	"Default (Dark)": load("res://themes/default_dark_theme.tres"),
	"Default (Light)": load("res://themes/default_light_theme.tres"),
	"Fresh Mint": load("res://themes/fresh_mint.tres"),
	"Grape": load("res://themes/grape.tres")
	# REMEMBER TO USE PALETTE FOR NEXT THEME
}

func _ready() -> void:
	for option: String in themes.keys():
		$Settings/Themes.add_item(option)
		
	match Main.launcher_data.theme:
		0: theme = themes["Default (Dark)"]
		1: theme = themes["Default (Light)"]
		2: theme = themes["Fresh Mint"]
		3: theme = themes["Grape"]
	$Settings/Themes.select(Main.launcher_data.theme)
	discord_setup()

func _on_option_button_item_selected(index: int) -> void:
	$Tap.play()
	var option: String = $Settings/Themes.get_item_text(index)
	theme = themes[option]
	Main.launcher_data.theme = index


func _on_music_finished() -> void:
	$Music.play()
func _on_shuffle_finished() -> void:
	$Shuffle.play()


func discord_setup() -> void:
	DiscordRPC.app_id = 1525720030002806876 # Application ID
	DiscordRPC.details = "Working hard on the Games you love!"
	
	DiscordRPC.state = splashes.pick_random()
	#DiscordRPC.large_image = "example_game" # Image key from "Art Assets"
	#DiscordRPC.large_image_text = "This does something large."
	#DiscordRPC.small_image = "boss" # Image key from "Art Assets"
	#DiscordRPC.small_image_text = "This does something small."

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	#DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"

	DiscordRPC.refresh()
