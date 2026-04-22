@icon("res://editor_icons/update.png")
extends Panel

## remind bulba he has to update the installer stuff now that this support all three core OS's
## issue with overlapping store pages again


func _ready():
	$"../Intro".queue_free()
	pass
	
	#if Main.launcher_data.just_installed == false:
		#$".".visible = true
		#
		#if FileAccess.file_exists("user://installer" + Main.file_type):
			#var absolute_path = ProjectSettings.globalize_path("user://installer" + Main.file_type)
			#OS.shell_open(absolute_path)
			#Main.launcher_data.just_installed = true
			#Main.save_data()
			#get_tree().quit()
		#else:
			#$"../HTTPRequest".download_file = "user://Package.zip"
			#match Main.operating_system:
				#"Windows": $"../HTTPRequest".request("https://github.com/Workaholic-Games/Ambition-Launcher/releases/download/installer/Ambition_Installer_Windows.zip")
				#
				#"macOS": $"../HTTPRequest".request("https://github.com/Workaholic-Games/Ambition-Launcher/releases/download/installer/Ambition_Installer_Mac.zip")
				#
				#"Linux": $"../HTTPRequest".request("https://github.com/Workaholic-Games/Ambition-Launcher/releases/download/installer/Ambition_Installer_Linux.zip")
	#
	#else:
		#Main.launcher_data.just_installed = false
		#$"../Intro".play()
		#$"../Intro/Intro Audio".play()



func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	var reader := ZIPReader.new()
	reader.open("user://Package.zip")
	var root_dir := DirAccess.open("user://")

	
	var files := reader.get_files()
	for file_path in files:
		if file_path.ends_with("/"):
			root_dir.make_dir(file_path)
			continue
		var buffer := reader.read_file(file_path)
		var file := FileAccess.open(root_dir.get_current_dir().path_join(file_path), FileAccess.WRITE)
		file.store_buffer(buffer)
	
	
	#var absolute_path = ProjectSettings.globalize_path("user://" + version_file_names.get(selected_link) + os_name + Main.file_type)
	#OS.shell_open(absolute_path)
		
	reader.close()
	DirAccess.remove_absolute("user://Package.zip")
	
	var absolute_path = ProjectSettings.globalize_path("user://Ambition_Installer_Windows.exe")
	match Main.operating_system:
		"Windows": absolute_path = ProjectSettings.globalize_path("user://Ambition_Installer_Windows.exe")
		"macOS": absolute_path = ProjectSettings.globalize_path("user://Ambition_Installer_Mac.app")
		"Linux": absolute_path = ProjectSettings.globalize_path("user://Ambition_Installer_Linux.x86_64")
	OS.shell_open(absolute_path)
	
	
	
	Main.launcher_data.just_installed = true
	Main.save_data()
	get_tree().quit()


func _on_intro_finished() -> void:
	$"../Intro".queue_free()
