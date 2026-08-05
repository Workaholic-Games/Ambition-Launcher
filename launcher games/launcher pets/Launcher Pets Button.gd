extends TextureButton



func _on_toggled(toggled_on: bool) -> void:
	$"../../Tap".play()
	if toggled_on:
		$"../Launcher Pets/HFlowContainer".show()
		$"../Launcher Pets/Size".show()
	else:
		$"../Launcher Pets/HFlowContainer".hide()
		$"../Launcher Pets/Size".hide()
