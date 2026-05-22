extends Control



func _on_dell_toggled(toggled_on: bool) -> void:
	match toggled_on:
		true: $".".visible = true
		false: $".".visible = false



func _on_who_dell_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "I am the virtual assistant created by Workaholic Games."
func _on_game_install_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "Click on the game you want to install. Then you will be in that game's Store Page. Then click the Install Button."
func _on_bug_report_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "If you have obtained a legitimate copy of this launcher you should have access to the Workaholic Games Discord Server. In said server we have a Bug Reporting Channel you can submit bugs to."
func _on_modding_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "We plan to add modding to the launcher once we have produced a game that will utilize it."
func _on_community_tab_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "If you upload any of your art/memes to the fanart channel in the Workaholic Games Discord Server your art can be selected by our developers to be featured in the Community Tab."
func _on_games_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "We are unsure of when any new games will be released. At the moment we can hopefully expect at least an announcement by the end of the year."
func _on_project_u_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "Project U is a codename for a game being developed by Bulba that will probably take quite some time to be announced."
func _on_veg_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "As of now he intends on finishing the game. However due to the complexities involved with developing a game of its scope it will take quite some time."
func _on_bulba_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "Bulba is the Founder and current owner of Workaholic Games. The Workaholic."
func _on_jonathan_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "Jonathan is a Developer for Workaholic Games. Currently the main developer of Gavin's Fantastically Fun Adventure and also one of the Head Developers of Ambition."
func _on_sawyer_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "Sawyer is another Founder of Workaholic Games. Currently working on something we're not sure to be honest."
func _on_join_us_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "If there is anything availible in the Job listings channel in the Workaholic Games Discord Server you may apply there. If not then you may ask one of our dev's to either join on a project. Or you may ask for one of your projects to enter the Workaholic Games brand."
func _on_server_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "We do not currently want others outside of our discord server obtaining our products for security reasons depending on the situation Bulba may make exceptions but make sure to ask him before distribution."
func _on_join_server_pressed() -> void:
	$Yap.visible = true
	$Yap.text = "Contact the staff at Workaholic Games and we may consider adding your companions to our server! :D"
