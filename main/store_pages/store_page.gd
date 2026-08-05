@icon("res://editor_icons/shop_item.png")
extends Control
class_name StorePage

@export var game : GameData

var os_name : String = "Windows"
var selected_link : int = 0
var can_download : bool = true



func _ready() -> void:
	if game.installable == false:
		$"Install or Back/Install".visible = false
	
	$"Game Description".text = game.description
	$"Stuff/Release Date".text = "Release Date: " + game.release_date
	$Stuff/Genre.text = "Genre: " + game.genre
	$Stuff/Difficulty.text = "Difficulty: " + game.difficulty
	$"Stuff/Age Rating".text = "Age Rating: " + game.age_rating
	$"Stuff/Main Dev".text = "Main Developer: " + game.main_dev
	$Stuff/Stability.text = "Stability: " + game.stability
	$"Stuff/Max Players".text = "Max Players: " + game.max_players
	
	
	for i in range(game.version_names.size()):
		match Main.operating_system:
			"Windows": 
				$"Versions Windows".visible = true
				$"Versions Windows".add_item(game.version_names[i])
				os_name = "_Windows"
			"macOS": 
				$"Versions Mac".visible = true
				$"Versions Mac".add_item(game.version_names[i])
				os_name = "_Mac"
			"Linux": 
				$"Versions Linux".visible = true
				$"Versions Linux".add_item(game.version_names[i])
				os_name = "_Linux"
	
	check_for_reinstall()

func _on_versions_item_selected(index: int) -> void:
	$"../../Tap".play()
	selected_link = index
	check_for_reinstall()

func _on_install_pressed() -> void:
	print("Install")
	$"../../Tap".play()
	
	if not DirAccess.dir_exists_absolute(game.folder_path):
		var err = DirAccess.make_dir_absolute(game.folder_path)
		
		if err == OK:
			pass
			
	if can_download == true:
		$HTTPRequest.download_file = game.folder_path + "//Package.zip"
		match Main.operating_system:
			"Windows": $HTTPRequest.request(game.version_links_windows.get(selected_link))
			"macOS": $HTTPRequest.request(game.version_links_mac.get(selected_link))
			"Linux": $HTTPRequest.request(game.version_links_linux.get(selected_link))
		
		can_download = false
		$ProgressBar.visible = false
		$ProgressBar.value = 0

# Download Complete code
func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	print("https complete")
	var reader := ZIPReader.new()
	var err = reader.open(game.folder_path + "//Package.zip")
	
	if err != OK:
		print("err != ok")
		$"Install or Back/Install".show()
		$ProgressBar.hide()
		return
	
	var files := reader.get_files()
	
	for file_path in files:
		if file_path.begins_with("__MACOSX") or file_path.get_file().begins_with("._"):
			continue
		
		var full_path = game.folder_path.path_join(file_path)
		
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
		
		var app_bundle_name = game.version_file_names_mac.get(selected_link) + ".app"
		var binary_name = game.version_file_names_mac.get(selected_link)
		
		var app_path_absolute = ProjectSettings.globalize_path(game.folder_path + "//" + app_bundle_name)
		
		if binary_name == "Five Nights At Bulbas 1.0":
			binary_name = "Five Nights At Bulbas"
		
		var binary_path_absolute = app_path_absolute.path_join("Contents/MacOS").path_join(binary_name)
		
		var chmod_err = OS.execute("chmod", ["+x", binary_path_absolute])
		if chmod_err != 0:
			print("Warning: chmod failed with code ", chmod_err)
			print(binary_path_absolute)
			print(app_path_absolute)
			print(binary_name)
			print(app_bundle_name)
		
		var xattr_err = OS.execute("xattr", ["-dr", "com.apple.quarantine", app_path_absolute])
		if xattr_err != 0:
			print("Warning: xattr failed with code ", xattr_err)
	
	DirAccess.remove_absolute(game.folder_path + "//Package.zip") 
	
	$ProgressBar.visible = false
	can_download = true
	check_for_reinstall()

func check_for_reinstall():
	var is_installed = false
	
	var path = game.folder_path + "//" + game.version_file_names_windows[selected_link] + ".exe"
	is_installed = FileAccess.file_exists(path)
	
	if is_installed != false:
		$"Install or Back/Install".text = "Reinstall"
	else:
		$"Install or Back/Install".text = "Install"

func _on_back_pressed() -> void:
	$"../../Tap".play()
	visible = false

# Progress Bar function
func _physics_process(_delta: float) -> void:
	if can_download == false:
		$ProgressBar.visible = true
		var downloaded = $HTTPRequest.get_downloaded_bytes()
		var total = $HTTPRequest.get_body_size()
		if total > 0:
			$ProgressBar.value = (float(downloaded) / total) * 100



## Developer @export variable setup example:
# Version Name: Ambition Edition
# Version Links Windows: (Windows Link)
# Version Links Mac: (Mac Link)
# Version Links Linux: (Linux Link)
# Version File Name: FNAB1_Ambition_Edition
# Folder Path: user://FOLDER NAME

# Ensure on the github side the zip is called TITLEHERE_Windows/Mac/Linux 
# and put them all under the same release for organization
