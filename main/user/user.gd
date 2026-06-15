extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "Hello " + Main.launcher_data.username

func _on_button_toggled(toggled_on: bool) -> void:
	match toggled_on:
		true: $"Avatar Selection".show()
		false: $"Avatar Selection".hide()


func _on_button_2_pressed() -> void:
	$"../Username".show()
