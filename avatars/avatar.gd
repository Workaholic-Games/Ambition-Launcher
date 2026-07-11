extends Panel

var avatar_instance = load("res://avatars/avatar_instance.tscn")
@export var default_avatars : Array[Texture2D]



func _ready() -> void:
	if Main.launcher_data.username == "":
		var random_avatar = randi_range(0, default_avatars.size()-1)
		Main.launcher_data.avatar = random_avatar
	
	for i in default_avatars.size():
		var new_avatar = avatar_instance.instantiate()
		new_avatar.index = i
		new_avatar.menu = self
		
		$"../User/Avatar Selection/ScrollContainer/GridContainer".add_child(new_avatar)
	
		$Avatar.texture_normal = default_avatars[Main.launcher_data.avatar]
		$"../User/Avatar/Avatar".texture = default_avatars[Main.launcher_data.avatar]

func update_avatar():
	$Avatar.texture_normal = default_avatars[Main.launcher_data.avatar]
	$"../User/Avatar/Avatar".texture = default_avatars[Main.launcher_data.avatar]
