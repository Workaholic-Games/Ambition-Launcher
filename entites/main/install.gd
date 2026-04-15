extends Control
@export var url : String
@export var file_name : String
@onready var httprequest = $"../../../HTTPRequest"
var can_download : bool = true


func _on_pressed() -> void:
	if can_download == true:
		httprequest.download_file = "user://" + file_name
		httprequest.request(url)
		can_download = false



func _on_http_request_request_completed(_result: int, _response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	print("INSTALLED")
	var absolute_path = ProjectSettings.globalize_path("user://" + file_name)
	OS.shell_open(absolute_path)
	can_download = true


func _physics_process(_delta: float) -> void:
	var downloaded = httprequest.get_downloaded_bytes()
	var total = httprequest.get_body_size()
			
	if total > 0:
		$"../../Progress Bar".value = (float(downloaded) / total) * 100
