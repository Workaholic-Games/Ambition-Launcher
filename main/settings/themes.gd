extends Control
#var themes: Dictionary[String, Theme] = {
	#"Default (Dark)": load("res://ui/themes/default_dark_theme.tres"),
	#"Default (Light)": load("res://ui/themes/default_light_theme.tres"),
	#"Fresh Mint": load("res://ui/themes/fresh_mint.tres"),
	#"Grape": load("res://ui/themes/grape.tres")
	#}



func _ready() -> void:
	return
	#for option: String in themes.keys():
		#$Settings/Themes.add_item(option)
		#
	
	#match Main.launcher_data.theme:
		#0: theme = themes["Default (Dark)"]
		#1: theme = themes["Default (Light)"]
		#2: theme = themes["Fresh Mint"]
		#3: theme = themes["Grape"]
	#$Settings/Themes.select(Main.launcher_data.theme)

func _on_option_button_item_selected(index: int) -> void:
	$Tap.play()
	var option: String = $Settings/Themes.get_item_text(index)
	#theme = themes[option]
	Main.launcher_data.theme = index

func _on_music_finished() -> void:
	$Music.play()
func _on_shuffle_finished() -> void:
	$Shuffle.play()
