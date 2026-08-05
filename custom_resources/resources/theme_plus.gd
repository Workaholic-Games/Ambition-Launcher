@tool
extends Theme
class_name ThemePlus



@export var font_color : Color = Color(1.0, 1.0, 1.0, 1.0):
	set(value):
		font_color = value
		set_color("font_color", "Button", value)
		notify_property_list_changed()

@export var accent_color : Color:
	set(value):
		accent_color = value
		var stylebox = StyleBoxFlat.new()
		stylebox.bg_color = value
		set_stylebox("panel", "Line", stylebox)
		notify_property_list_changed()

@export var background_panel : StyleBox:
	set(value):
		background_panel = value
		set_stylebox("panel", "Panel", value)
		notify_property_list_changed()



@export var tab_button_normal : Color:
	set(value):
		tab_button_normal = value
		
		var stylebox = StyleBoxFlat.new()
		stylebox.bg_color = value
		stylebox.border_color = accent_color
		set_stylebox("normal", "TabButton", stylebox)
@export var tab_button_hover : Color:
	set(value):
		tab_button_hover = value
		
		var stylebox = StyleBoxFlat.new()
		stylebox.bg_color = value
		stylebox.border_color = accent_color
		stylebox.border_width_left = 2
		set_stylebox("hover", "TabButton", stylebox)
@export var tab_button_pressed : Color:
	set(value):
		tab_button_pressed = value
		
		var stylebox = StyleBoxFlat.new()
		stylebox.bg_color = value
		stylebox.border_color = accent_color
		stylebox.border_width_left = 2
		set_stylebox("pressed", "TabButton", stylebox)
