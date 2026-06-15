extends Panel

var default_avatars =  [
	load("res://branding/gobletv2_upscaled.png"),
	load("res://branding/godot_v2.png"),
]


func _ready() -> void:
	if Main.launcher_data.username == "":
		var random_avatar = randi_range(0, default_avatars.size()-1)
		$Avatar.texture_normal = default_avatars[random_avatar]
		Main.launcher_data.avatar = random_avatar
	else:
		$Avatar.texture_normal = default_avatars[Main.launcher_data.avatar]
		$"../User/Avatar/Avatar".texture = default_avatars[Main.launcher_data.avatar]
