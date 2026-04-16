extends Panel



func _ready():
	$"../Intro".queue_free()
	pass
	#if Main.launcher_data.just_installed == false:
		#$".".visible = true
		#
		#if FileAccess.file_exists("user://installer.exe"):
			#var absolute_path = ProjectSettings.globalize_path("user://installer.exe")
			#OS.shell_open(absolute_path)
			#Main.launcher_data.just_installed = true
			#Main.save_data()
			#get_tree().quit()
		#else:
			#$"../HTTPRequest".download_file = "user://installer.exe"
			#$"../HTTPRequest".request("https://github.com/Workaholic-Games/Ambition-Launcher/releases/download/installer/Ambition.Installer.exe")
	#else:
		#Main.launcher_data.just_installed = false
		#$"../Intro".play()
		#$"../Intro/Intro Audio".play()



func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	var absolute_path = ProjectSettings.globalize_path("user://installer.exe")
	OS.shell_open(absolute_path)
	Main.launcher_data.just_installed = true
	Main.save_data()
	get_tree().quit()


func _on_intro_finished() -> void:
	$"../Intro".queue_free()
