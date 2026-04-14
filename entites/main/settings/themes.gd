extends Control

var themes: Dictionary[String, Theme] = {
	"Default (Dark)": load("res://themes/default_dark_theme.tres"),
	"Default (Light)": load("res://themes/default_light_theme.tres"),
	"Fresh Mint": load("res://themes/fresh_mint.tres"),
	"Grape": load("res://themes/grape.tres")
	# REMEMBER TO USE PALETTE FOR NEXT THEME
}

func _ready() -> void:
	for option: String in themes.keys():
		$Panel/Tabs/Buttons/Settings/Settings/Themes.add_item(option)
		
	match Main.launcher_data.theme:
		0: theme = themes["Default (Dark)"]
		1: theme = themes["Default (Light)"]
		2: theme = themes["Fresh Mint"]
		3: theme = themes["Grape"]
	$Panel/Tabs/Buttons/Settings/Settings/Themes.select(Main.launcher_data.theme)



func _on_option_button_item_selected(index: int) -> void:
	var option: String = $Panel/Tabs/Buttons/Settings/Settings/Themes.get_item_text(index)
	theme = themes[option]
	Main.launcher_data.theme = index


# need to add saving what theme is selected
