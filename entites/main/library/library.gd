extends ScrollContainer



func _ready() -> void:
	$GridContainer.queue_sort()



func _on_library_visibility_changed() -> void:
	for i in $GridContainer.get_children():
		i.check()
