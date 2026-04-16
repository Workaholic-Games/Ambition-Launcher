extends Panel



func _ready():
	# Connect the signal to handle the response
	$"../HTTPRequest".request_completed.connect(_on_request_completed)
	
	var error = $"../HTTPRequest".request(version_url)
	if error != OK:
		push_error("An error occurred in the HTTP request.")



func _on_request_completed(_result, _response_code, _headers, body):
	var remote_content = body.get_string_from_utf8()
	var remote_version = float(remote_content.strip_edges())
	print("Remote number found: ", remote_version)
