extends Panel

var i : int = 0
var j : int = 0
var text : Array = [
	"Reloading",
	"Reloading.",
	"Reloading..",
	"Reloading..."
]

func _on_timer_timeout() -> void:
	print(i)
	$Label.text = text[i]
	if i == 3:
		i = 0
		j += 1
		if j == 2:
			$Timer.stop()
			Main.load_data()
			hide()
			$"../User/Label".text = "Hello " + Main.launcher_data.username
			j = 0
	else:
		i += 1
