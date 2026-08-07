extends Node2D
var file_path = "user://save/"
var file_name = "data.res"
var launcher_data = data.new()
var operating_system : String = OS.get_name()
var file_type : String = ".exe"
@export var games : PackedStringArray



func _ready():
	match operating_system:
		"Windows": file_type = ".exe"
		"macOS": file_type = ".app"
		"Linux": file_type = ".x86_64"
	
	DirAccess.make_dir_absolute(file_path)
	load_data()
	print(launcher_data.username)

# Save Data related
func load_data():
	if (ResourceLoader.exists(file_path + file_name)):
		launcher_data = ResourceLoader.load(file_path + file_name).duplicate(true)

func save_data():
	ResourceSaver.save(launcher_data, file_path + file_name)

# Save game when you click X and I believe Alt-F4
func _exit_tree() -> void:
	save_data()



func is_application_running(application_name : String) -> bool:
	var os_type = OS.get_name()
	match os_type:
		"Windows": return check_windows_processes(application_name)
		"macOS": return check_mac_processes(application_name)
		"Linux": return check_linux_processes(application_name)
		_: return false

func check_windows_processes(application_name : String) -> bool:
	var output = []
	OS.execute("tasklist", [], output)
	return output[0].to_lower().find(application_name) != -1

func check_mac_processes(application_name : String) -> bool:
	var output = []
	var exit_code = OS.execute("pgrep", ["-x", application_name], output)
	return exit_code == 0

func check_linux_processes(application_name : String) -> bool:
	var output = []
	var exit_code = OS.execute("pgrep", ["-x", application_name], output)
	return exit_code == 0
