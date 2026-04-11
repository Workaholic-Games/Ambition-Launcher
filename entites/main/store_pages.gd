extends Control



func _on_fnab_versions_item_selected(index: int) -> void:
	match index:
		0: $"FNAB/Version Changes".text = "Ambition Edition - Changelog:
-Fixed Bulba and Gigabot overlapping
-Remade the Eternal Night system"
		1: $"FNAB/Version Changes".text = "1.1 - Changelog:
-Added Night 6
-Added Eternal Night"
		2: $"FNAB/Version Changes".text = "This is a Demo Version."
