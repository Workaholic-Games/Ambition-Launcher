extends Button



func _on_pressed() -> void:
	$"../Library/Library".visible = false
	$"../Store/Store".visible = false
	$"../Store/Store Pages".visible = false
	$"../Community/Community".visible = false
	$"../Changelog/Changelog".visible = true
	$"../Developers/Developers".visible = false
	$"../Settings/Settings".visible = false
