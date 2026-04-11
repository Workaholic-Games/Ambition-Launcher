extends Node2D

var path = "user://save/data.res"
var launcher_data = data.new()

func _ready():
	DirAccess.make_dir_absolute(path)
	load_data()

func load_data():
	if (ResourceLoader.exists(path)):
		launcher_data = ResourceLoader.load(path).duplicate(true)
		print("LOADED")
	else:
		print("NO SAVE DATA FOUND. CREATED NEW FILE")

func save_data():
	ResourceSaver.save(launcher_data, path)
	print("SAVED!")
