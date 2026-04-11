extends Button


func _on_pressed() -> void:
	$"../Library/Library".visible = false
	$"../Store/Store".visible = false
	$"../Store/Store Pages".visible = false
	$"../Community/Community".visible = true
	$"../Changelog/Changelog".visible = false
	$"../Developers/Developers".visible = false
	$"../Settings/Settings".visible = false
