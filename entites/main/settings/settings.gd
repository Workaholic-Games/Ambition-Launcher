extends Control



func _ready():
	# Connect to the root viewport's size_changed signal
	get_tree().root.size_changed.connect(_on_window_size_changed)



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



func _on_window_size_changed():
	var mode = DisplayServer.window_get_mode()
	if mode == DisplayServer.WINDOW_MODE_MAXIMIZED:
		$Window.select(1)
	elif mode == DisplayServer.WINDOW_MODE_WINDOWED:
		$Window.select(0)
	elif mode == DisplayServer.WINDOW_MODE_MINIMIZED:
		$Window.select(0)
	elif mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		$Window.select(2)
	elif mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		$Window.select(3)
