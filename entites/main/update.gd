@icon("res://editor_icons/update.png")
extends Panel

## remind bulba he has to update the installer stuff now that this support all three core OS's
## issue with overlapping store pages again


func _ready():
	$"../Intro".queue_free()
	
	if Main.launcher_data.just_installed == false:
		$".".visible = true
		
		if FileAccess.file_exists("user://installer" + Main.file_type):
			var absolute_path = ProjectSettings.globalize_path("user://installer" + Main.file_type)
			OS.shell_open(absolute_path)
			Main.launcher_data.just_installed = true
			Main.save_data()
			print("ATTEMPTED TO OPEN - ALREADY HAVE INSTALLER")
			get_tree().quit()
		else:
			print("INSTALLING")
			$"../HTTPRequest".download_file = "user://Package.zip"
			match Main.operating_system:
				"Windows": $"../HTTPRequest".request("https://github.com/Workaholic-Games/Ambition-Launcher/releases/download/installer/Ambition_Installer_Windows.zip")
				
				"macOS": $"../HTTPRequest".request("https://github.com/Workaholic-Games/Ambition-Launcher/releases/download/installer/Ambition_Installer_Mac.zip")
				
				"Linux": $"../HTTPRequest".request("https://github.com/Workaholic-Games/Ambition-Launcher/releases/download/installer/Ambition_Installer_Linux.zip")
	
	else:
		Main.launcher_data.just_installed = false
		$"../Intro".play()
		$"../Intro/Intro Audio".play()



func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	var reader := ZIPReader.new()
	var err = reader.open("user://Package.zip")
	
	if err != OK:
		print("Failed to open ZIP: ", err)
		return
	var files := reader.get_files()
	
	for file_path in files:
		if file_path.begins_with("__MACOSX") or file_path.get_file().begins_with("._"):
			continue
		
		var full_path = "user://".path_join(file_path)
		print(full_path)
		if file_path.ends_with("/"):
			DirAccess.make_dir_recursive_absolute(full_path)
			continue
	
		var parent_dir = full_path.get_base_dir()
		if !DirAccess.dir_exists_absolute(parent_dir):
			DirAccess.make_dir_recursive_absolute(parent_dir)
	
		var buffer := reader.read_file(file_path)
		var file := FileAccess.open(full_path, FileAccess.WRITE)
		if file:
			file.store_buffer(buffer)
			file.flush()
			file.close()
	reader.close()
	
	
	if OS.get_name() == "macOS":
		var app_bundle_name = "Ambition Installer.app" 
		var binary_name = "Ambition Installer"
		
		var app_path_absolute = ProjectSettings.globalize_path("user://" + app_bundle_name)
		var binary_path_absolute = app_path_absolute.path_join("Contents/MacOS").path_join(binary_name)
		
		var chmod_err = OS.execute("chmod", ["+x", binary_path_absolute])
		if chmod_err != 0:
			print("Warning: chmod failed with code ", chmod_err)
		
		var xattr_err = OS.execute("xattr", ["-dr", "com.apple.quarantine", app_path_absolute])
		if xattr_err != 0:
			print("Warning: xattr failed with code ", xattr_err)
	
	
	DirAccess.remove_absolute("user://Package.zip") 
	
	
	
	var absolute_path = ProjectSettings.globalize_path("user://Ambition_Installer_Windows.exe")
	match Main.operating_system:
		"Windows": 
			absolute_path = ProjectSettings.globalize_path("user://Ambition_Installer_Windows.exe")
			OS.shell_open(absolute_path)
		"macOS": 
			absolute_path = ProjectSettings.globalize_path("user://Ambition_Installer_Windows.app")
			OS.shell_open("file://" + absolute_path)
		"Linux": 
			OS.execute("chmod", ["+x", ProjectSettings.globalize_path("user://Ambition_Installer_Linux")])
			OS.create_process(ProjectSettings.globalize_path("user://Ambition_Installer_Linux"), [])
	
	if !FileAccess.file_exists("user://Ambition_Installer_Linux"):
		print("NO LINUX INSTALLER")
	
	Main.launcher_data.just_installed = true
	Main.save_data()
	get_tree().quit()



func _on_intro_finished() -> void:
	$"../Intro".queue_free()
