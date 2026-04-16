extends Panel
var current_version : int = 0
var path : String = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP) #OS.get_executable_path()



func _ready():
	$"../Download Check".request("https://raw.githubusercontent.com/bulbatf7-lgtm/Version-Checker/refs/heads/main/README.md")



func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	var version_number = body.get_string_from_utf8()
	print("Remote number found: ", version_number)
	
	if int(version_number) > current_version:
		DirAccess.remove_absolute(path + "/Ambition_Test.exe")
		$"../Install Update".download_file = path + "/Ambition_Test.exe"
		$"../Install Update".request("https://github.com/bulbatf7-lgtm/Version-Checker/releases/download/ambition/Ambition_Test.exe")
	else:
		print("ON LATEST VERSION")



func _on_install_update_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	get_tree().quit()
	OS.shell_open($"../Install Update".download_file)


# need to make sure this all like works properly
