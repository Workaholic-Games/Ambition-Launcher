extends Control
@export_multiline var description : String
@export_multiline var rating : String
@export var versions : PackedStringArray
@export var version_links : PackedStringArray
@export var version_file_names : PackedStringArray
var selected_link : int = 0
var can_download : bool = true



func _ready() -> void:
	$"Game Description".text = description
	$"Age Rating".text = rating
	for version: String in versions:
		$Versions.add_item(version)
	
	match version_file_names.get(0):
		"FNAB1_Ambition_Edition": $Thumbnail.play("fnab1")
		"FNAB2_Ambition_Edition": $Thumbnail.play("fnab2")
		"Bitcoin_Miner.1.25": $Thumbnail.play("bitcoin_miner")



func _on_versions_item_selected(index: int) -> void:
	selected_link = index
	check_for_uninstall()


# Installation and Uninstallation
func _on_install_pressed() -> void:
	if can_download == true and $Install.text == "Install":
		$HTTPRequest.download_file = "user://" + version_file_names.get(selected_link) + ".exe"
		$HTTPRequest.request(version_links.get(selected_link))
		can_download = false
		$ProgressBar.visible = false
	elif can_download == true and $Install.text == "Uninstall":
		DirAccess.remove_absolute("user://" + version_file_names.get(selected_link) + ".exe")
		$Install.text = "Install"


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



# Download Complete code
func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	var absolute_path = ProjectSettings.globalize_path("user://" + version_file_names.get(selected_link) + ".exe")
	OS.shell_open(absolute_path)
	can_download = true
	$ProgressBar.visible = false
	check_for_uninstall()



# Crap to check if you can Uninstall the game
func _on_visibility_changed() -> void:
	check_for_uninstall()


func check_for_uninstall():
	if FileAccess.file_exists("user://" + version_file_names.get(selected_link) + ".exe"):
		$Install.text = "Uninstall"
