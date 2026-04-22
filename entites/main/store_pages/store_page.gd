@icon("res://editor_icons/shop_item.png")
extends Control
@export_multiline var description : String
@export_multiline var rating : String

## The names that will be displayed in engine
@export var version_names : PackedStringArray

@export var version_links_windows : PackedStringArray
@export var version_links_mac : PackedStringArray
@export var version_links_linux : PackedStringArray

## The actual file name for the application
@export var version_file_names : PackedStringArray
@export var cover : Texture
var os_name : String = "Windows"
var selected_link : int = 0
var can_download : bool = true





func _ready() -> void:
	$"Game Description".text = description
	$"Age Rating".text = rating
	$Thumbnail.texture = cover
	
	for version: String in version_names:
		match Main.operating_system:
			"Windows": $"Versions Windows".add_item(version)
			"macOS": $"Versions Mac".add_item(version)
			"Linux": $"Versions Linux".add_item(version)
		
	
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
			"Linux": $HTTPRequest.request(version_links_linux.get(selected_link))
		
		can_download = false
		$ProgressBar.visible = false
		$ProgressBar.value = 0



# Download Complete code
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
