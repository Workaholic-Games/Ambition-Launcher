extends Node2D
var file_path = "user://save/"
var file_name = "data.res"
var launcher_data = data.new()



func _ready():
	DirAccess.make_dir_absolute(file_path)
	load_data()
	print(launcher_data.window_mode)


func load_data():
	if (ResourceLoader.exists(file_path)):
		launcher_data = ResourceLoader.load(file_path + file_name).duplicate(true)
		print("LOADED")
	else:
		print("NO SAVE DATA FOUND. CREATED NEW FILE")

func save_data():
	ResourceSaver.save(launcher_data, file_path + file_name)
	print("SAVED!")



func _exit_tree() -> void:
	save_data()
