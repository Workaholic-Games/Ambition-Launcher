extends Node2D
var file_path = "user://save/"
var file_name = "data.res"
var launcher_data = data.new()



func _ready():
	DirAccess.make_dir_absolute(file_path)
	load_data()


# Save Data related
func load_data():
	if (ResourceLoader.exists(file_path + file_name)):
		launcher_data = ResourceLoader.load(file_path + file_name).duplicate(true)

func save_data():
	ResourceSaver.save(launcher_data, file_path + file_name)


# Save game when you click X and I believe Alt-F4
func _exit_tree() -> void:
	save_data()
