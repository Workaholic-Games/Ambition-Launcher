extends Panel


func _on_yes_pressed() -> void:
	Main.save_data()
	get_tree().quit()


func _on_no_pressed() -> void:
	self.visible = false
	match Main.launcher_data.start_page:
		0: 
			$"../Panel/Tabs/Buttons/Library".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Library".set_pressed_no_signal(true)
		1: 
			$"../Panel/Tabs/Buttons/Store".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Store".set_pressed_no_signal(true)
		2: 
			$"../Panel/Tabs/Buttons/Community".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Community".set_pressed_no_signal(true)
		3: 
			$"../Panel/Tabs/Buttons/Changelog".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Changelog".set_pressed_no_signal(true)
		4: 
			$"../Panel/Tabs/Buttons/Developers".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Developers".set_pressed_no_signal(true)
		5: 
			$"../Panel/Tabs/Buttons/Settings".emit_signal("pressed")
			$"../Panel/Tabs/Buttons/Settings".set_pressed_no_signal(true)
	$"../Panel/Tabs/Buttons/Quit Launcher".set_pressed_no_signal(false)
