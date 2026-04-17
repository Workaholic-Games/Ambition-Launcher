@icon("res://editor_icons/settings.png")
extends Control



# Applying of settings on startup
func _ready():
	fix_option_button_ui()
	match Main.launcher_data.window_mode:
		0: $Window.emit_signal("item_selected", 0)
		1: $Window.emit_signal("item_selected", 1)
		2: $Window.emit_signal("item_selected", 2)
		3: $Window.emit_signal("item_selected", 3)
	
	match Main.launcher_data.start_page:
		0: 
			$"Startup Location".select(0)
			$"../Panel/Tabs/Buttons/Library".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Library".set_pressed_no_signal(true)
		1: 
			$"Startup Location".select(1)
			$"../Panel/Tabs/Buttons/Store".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Store".set_pressed_no_signal(true)
		2: 
			$"Startup Location".select(2)
			$"../Panel/Tabs/Buttons/Community".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Community".set_pressed_no_signal(true)
		3: 
			$"Startup Location".select(3)
			$"../Panel/Tabs/Buttons/Changelog".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Changelog".set_pressed_no_signal(true)
		4: 
			$"Startup Location".select(4)
			$"../Panel/Tabs/Buttons/Developers".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Developers".set_pressed_no_signal(true)
		5: 
			$"Startup Location".select(5)
			$"../Panel/Tabs/Buttons/Settings".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Settings".set_pressed_no_signal(true)


# Window settings
func _on_window_item_selected(index: int) -> void:
	match index:
		0: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			Main.launcher_data.window_mode = 0
		1: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
			Main.launcher_data.window_mode = 1
		2: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			Main.launcher_data.window_mode = 2
		3: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			Main.launcher_data.window_mode = 3


# Updating setting if you click F11 and such
func _process(_delta: float) -> void:
	var mode = DisplayServer.window_get_mode()
	if mode == DisplayServer.WINDOW_MODE_MAXIMIZED: $Window.select(1)
	elif mode == DisplayServer.WINDOW_MODE_WINDOWED: $Window.select(0)
	elif mode == DisplayServer.WINDOW_MODE_MINIMIZED: $Window.select(0)
	elif mode == DisplayServer.WINDOW_MODE_FULLSCREEN: $Window.select(2)
	elif mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN: $Window.select(3)
	
	if Input.is_action_just_pressed("fullscreen"):
		if mode == DisplayServer.WINDOW_MODE_FULLSCREEN: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			Main.launcher_data.window_mode = 0
		elif mode != DisplayServer.WINDOW_MODE_FULLSCREEN: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			Main.launcher_data.window_mode = 3



# Move user to Startup Location
func _on_startup_location_item_selected(index: int) -> void:
	Main.launcher_data.start_page = index



# Fixes the stupid option buttons not being rendered properly
func fix_option_button_ui():
	var option_buttons = get_tree().get_root().find_children("*", "OptionButton", true, false)
	for button in option_buttons:
		button.get_popup().canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
