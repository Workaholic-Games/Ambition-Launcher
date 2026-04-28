@icon("res://editor_icons/shop_item.png")
extends Control
@export_multiline var description : String
@export_multiline var rating : String

## The names that will be displayed in engine
@export var version_names : PackedStringArray

@export var version_links_windows : PackedStringArray
@export var version_links_mac : PackedStringArray
@export var version_links_linux : PackedStringArray

## The .exe .app or .x86_64 file names to be opened by the launcher
@export var version_file_names_windows : PackedStringArray
@export var version_file_names_mac : PackedStringArray
@export var version_file_names_linux : PackedStringArray

@export var cover : Texture
var os_name : String = "Windows"
var selected_link : int = 0
var can_download : bool = true



func _ready() -> void:
	$"Game Description".text = description
	$"Age Rating".text = rating
	$Thumbnail.texture = cover
	match Main.operating_system:
		"Windows": 
			$"Versions Windows".visible = true
			os_name = "_Windows"
		"macOS": 
			$"Versions Mac".visible = true
			os_name = "_Mac"
		"Linux": 
			$"Versions Linux".visible = true
			os_name = "_Linux"



func _on_versions_item_selected(index: int) -> void:
	selected_link = index


func _on_install_pressed() -> void:
	if can_download == true and $Install.text == "Install":
		$HTTPRequest.download_file = "user://Package.zip"
		match Main.operating_system:
			"Windows": $HTTPRequest.request(version_links_windows.get(selected_link))
			"macOS": $HTTPRequest.request(version_links_mac.get(selected_link))
		
		can_download = false
		$ProgressBar.visible = false
		$ProgressBar.value = 0



# Download Complete code
func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	var reader := ZIPReader.new()
	var err = reader.open("user://Package.zip")
	
	if err != OK:
		return
	var files := reader.get_files()
	
	for file_path in files:
		if file_path.begins_with("__MACOSX") or file_path.get_file().begins_with("._"):
			continue
		
		var full_path = "user://".path_join(file_path)
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
			absolute_path = ProjectSettings.globalize_path("user://Ambition Installer.app")
			OS.shell_open("file://" + absolute_path)
	
	$ProgressBar.visible = false
	can_download = true



func _on_back_pressed() -> void:
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

# Ensure on the github side the zip is called TITLEHERE_Windows/Mac/Linux 
# and put them all under the same release for organization
