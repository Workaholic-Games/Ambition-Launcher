extends Control
@export var themes: Array[Theme] = []
@export var theme_names : Array[String] = []



func _ready() -> void:
	for option: String in theme_names:
		$Settings/Themes.add_item(option)
		
	for theme_to_change in themes:
		match Main.launcher_data.font:
			0: theme_to_change.default_font = load("res://ui/fonts/Tiny5-Regular.ttf")
			1: theme_to_change.default_font = load("res://ui/fonts/GoogleSans-VariableFont_GRAD,opsz,wght.ttf")
			2: theme_to_change.default_font = load("res://ui/fonts/Jersey25-Regular.ttf")
			3: theme_to_change.default_font = load("res://ui/fonts/Coolville.otf")
			4: theme_to_change.default_font = load("res://ui/fonts/PixelifySans-VariableFont_wght.ttf")
	
	theme = themes[Main.launcher_data.theme]
	$Settings/Themes.select(Main.launcher_data.theme)
	$Settings/Font.select(Main.launcher_data.font)

func _on_themes_item_selected(index: int) -> void:
	$Tap.play()
	theme = themes[index]
	Main.launcher_data.theme = index

func _on_music_finished() -> void:
	$Music.play()
func _on_shuffle_finished() -> void:
	$Shuffle.play()


func _on_font_item_selected(index: int) -> void:
	for theme_to_change in themes:
		match index:
			0: theme_to_change.default_font = load("res://ui/fonts/Tiny5-Regular.ttf")
			1: theme_to_change.default_font = load("res://ui/fonts/GoogleSans-VariableFont_GRAD,opsz,wght.ttf")
			2: theme_to_change.default_font = load("res://ui/fonts/Jersey25-Regular.ttf")
			3: theme_to_change.default_font = load("res://ui/fonts/Coolville.otf")
			4: theme_to_change.default_font = load("res://ui/fonts/PixelifySans-VariableFont_wght.ttf")
	
	Main.launcher_data.font = index
