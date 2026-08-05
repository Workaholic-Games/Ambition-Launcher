@icon("res://editor_icons/account.png")
extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "Hello " + Main.launcher_data.username

func _on_change_avatar_pressed() -> void:
	$"../Tap".play()
	$"Avatar Selection".show()

func _on_button_2_pressed() -> void:
	$"../Tap".play()
	$"../Username".show()
	$"../Username/Close".show()

func _on_back_pressed() -> void:
	$"../Tap".play()
	$"../Avatar".show()
	hide()


func _on_button_pressed() -> void:
	$"Avatar Selection".hide()
