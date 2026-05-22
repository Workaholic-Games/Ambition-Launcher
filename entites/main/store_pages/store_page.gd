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

@export var folder_path : String = "user://Test"

@export var Images : Array[Texture]

var os_name : String = "Windows"
var selected_link : int = 0
var can_download : bool = true


func _ready() -> void:
	$"Game Description".text = description
	$"Age Rating".text = rating
	
	for image in Images.size():
		print(image)
		var new_image = Panel.new()
		new_image.position.y = -104.174
		new_image.size = Vector2(344, 208.348)
		new_image.theme_type_variation = "Line"
		$CarouselContainer/Control.add_child(new_image)
		
		var thumbnail = Sprite2D.new()
		thumbnail.scale = Vector2(0.171, 0.178)
		thumbnail.texture = Images.get(image)
		thumbnail.position = Vector2(172.0, 104.0)
		new_image.add_child(thumbnail)
		print(new_image)
	
	for i in range(version_names.size()):
		match Main.operating_system:
			"Windows": 
				$"Versions Windows".visible = true
				$"Versions Windows".add_item(version_names[i])
				os_name = "_Windows"
			"macOS": 
				$"Versions Mac".visible = true
				$"Versions Mac".add_item(version_names[i])
				os_name = "_Mac"
			"Linux": 
				$"Versions Linux".visible = true
				$"Versions Linux".add_item(version_names[i])
				os_name = "_Linux"

func _on_versions_item_selected(index: int) -> void:
	selected_link = index

func _on_install_pressed() -> void:
	print("Install")
	
	if not DirAccess.dir_exists_absolute(folder_path):
		var err = DirAccess.make_dir_absolute(folder_path)
		
		if err == OK:
			pass
			
	if can_download == true and $Install.text == "Install":
		$HTTPRequest.download_file = folder_path + "//Package.zip"
		match Main.operating_system:
			"Windows": $HTTPRequest.request(version_links_windows.get(selected_link))
			"macOS": $HTTPRequest.request(version_links_mac.get(selected_link))
		
		can_download = false
		$ProgressBar.visible = false
		$ProgressBar.value = 0

# Download Complete code
func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	print("https complete")
	var reader := ZIPReader.new()
	var err = reader.open(folder_path + "//Package.zip")
	
	if err != OK:
		print("err != ok")
		return

	var files := reader.get_files()
	
	for file_path in files:
		if file_path.begins_with("__MACOSX") or file_path.get_file().begins_with("._"):
			continue
		
		var full_path = folder_path.path_join(file_path)
		
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
		
		var app_bundle_name = version_file_names_mac.get(selected_link) + ".app"
		var binary_name = version_file_names_mac.get(selected_link)
		
		var app_path_absolute = ProjectSettings.globalize_path(folder_path + "//" + app_bundle_name)
		
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
	
	DirAccess.remove_absolute(folder_path + "//Package.zip") 
	
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
	if $CarouselContainer.selected_index == 0:
		$"Left Button".visible = false
	else:
		$"Left Button".visible = true
		
	if $CarouselContainer.selected_index == Images.size() - 1:
		$"Right Button".visible = false
	else:
		$"Right Button".visible = true
## Developer @export variable setup example:
# Version Name: Ambition Edition
# Version Links Windows: (Windows Link)
# Version Links Mac: (Mac Link)
# Version Links Linux: (Linux Link)
# Version File Name: FNAB1_Ambition_Edition
# Folder Path: user://FOLDER NAME

# Ensure on the github side the zip is called TITLEHERE_Windows/Mac/Linux 
# and put them all under the same release for organization


func _on_left_button_pressed() -> void:
	$CarouselContainer._left()

func _on_right_button_pressed() -> void:
	$CarouselContainer._right()
