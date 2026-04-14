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
	theme = themes["Default (Dark)"]



func _on_option_button_item_selected(index: int) -> void:
	var option: String = $Panel/Tabs/Buttons/Settings/Settings/Themes.get_item_text(index)
	theme = themes[option]


# need to add saving what theme is selected
