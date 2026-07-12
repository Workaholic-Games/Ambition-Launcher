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

func _on_option_button_item_selected(index: int) -> void:
	$Tap.play()
	var option: String = $Settings/Themes.get_item_text(index)
	theme = themes[option]
	Main.launcher_data.theme = index


func _on_music_finished() -> void:
	$Music.play()
func _on_shuffle_finished() -> void:
	$Shuffle.play()
