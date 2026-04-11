extends Control



func _ready() -> void:
	$"FNAB/FNAB Versions".get_popup().canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	
	#$"FNAB2/FNAB2 Versions".get_popup().canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST

func _on_fnab_versions_item_selected(index: int) -> void:
	match index:
		0: $"FNAB/Version Changes".text = "Important Changes:
-Fixed Bulba and Gigabot overlapping
-Remade the Eternal Night system"
		1: $"FNAB/Version Changes".text = "Important Changes:
-Added Night 6
-Added Eternal Night"
		2: $"FNAB/Version Changes".text = "This is a Demo Version."



func _on_fnab_2_versions_item_selected(index: int) -> void:
	match index:
		0: $"FNAB2/Version Changes".text = "Important Changes:
-Rebalanced Night 6 to be more fair.
-Tweaked Gigabot to be more unforgiving. However he know always changes pose when you enter the closet."
			
		1: $"FNAB2/Version Changes".text = "Important Changes:
-Added Night 6
-Added the new Minigame Bulbas Adventure
-Added Custom Night
-Added Challenges
-Added Texting Segments in between nights
-Updated Gavin and Bulba's Jumpscares
-Added Camera Labeling
-Added Classic Camera UI toggle in the Settings
-Added Voice lines when The Emotional Support Fries are clicked
-Added chance to have some special things to happen on death"
