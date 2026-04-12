extends Control

var themes: Dictionary[String, Theme] = {
	"Default (Dark)": load("res://themes/default_dark_theme.tres"),
	"Default (Light)": load("res://themes/default_light_theme.tres"),
	"Ocean Breeze": load("res://themes/ocean_breeze.tres")
}

func _ready() -> void:
	for option: String in themes.keys():
		$Panel/Tabs/Buttons/Settings/Settings/OptionButton.add_item(option)
	theme = themes["Default (Dark)"]



func _on_option_button_item_selected(index: int) -> void:
	var option: String = $Panel/Tabs/Buttons/Settings/Settings/OptionButton.get_item_text(index)
	theme = themes[option]
