extends Button

func _on_pressed():
	$Store.visible = true
	$"../Library/Library".visible = false
