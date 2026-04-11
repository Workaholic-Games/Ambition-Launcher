extends Button

func _on_pressed():
	$"../Library/Library".visible = false
	$"../Store/Store".visible = true
	$"../Store/Store Pages".visible = false
	$"../Community/Community".visible = false
	$"../Changelog/Changelog".visible = false
	$"../Developers/Developers".visible = false
	$"../Settings/Settings".visible = false
