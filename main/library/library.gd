extends ScrollContainer



func _ready() -> void:
	$GridContainer.queue_sort()


func _on_library_visibility_changed() -> void:
	print("VISIBILTY CHANGED")
	for i in $GridContainer.get_children():
		i.check()
