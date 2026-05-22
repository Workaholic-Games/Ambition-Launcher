extends Node2D

func _ready() -> void:
	var date = Time.get_date_dict_from_system()
	if date["month"] == 12:
		$Snow.visible = true
