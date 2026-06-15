extends Panel

var avatar_instance = load("res://entites/main/avatar_instance.tscn")
var default_avatars = [
	load("res://avatars/fnab1_arthur.png"),
	load("res://avatars/fnab1_bulba.png"),
	load("res://avatars/fnab1_charlie.png"),
	load("res://avatars/fnab1_claire.png"),
	load("res://avatars/fnab1_gigabot.png"),
	load("res://avatars/fnab1_mark.png"),
	load("res://avatars/fnab2_bobbleheads.png"),
	load("res://avatars/fnab2_bulba.png"),
	load("res://avatars/fnab2_charlie.png"),
	load("res://avatars/fnab2_claire.png"),
	load("res://avatars/fnab2_gavin.png"),
	load("res://avatars/fnab2_gigabot.png"),
	load("res://avatars/fnab2_mark.png"),
	load("res://avatars/fnab2_nightguard.png"),
	load("res://avatars/fnab2_ninjabot.png"),
	load("res://avatars/fnab2_sawyer.png"),
	load("res://avatars/fnab2_theoriginal.png"),
	load("res://avatars/seedling.png"),
	load("res://avatars/tater.png"),
	load("res://avatars/moon_motivational.png"),
	load("res://avatars/scaryhead_icon.png"),
	load("res://avatars/sad_sun.png"),
	load("res://avatars/the_mold.png"),
	load("res://avatars/the_carrots.png")
	]



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
