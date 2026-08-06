@tool
extends Theme
class_name ThemePlus

@export_tool_button("Kill") var kill = kill_stuff
@export var thing_to_kill : String

var line_stylebox : StyleBoxFlat = StyleBoxFlat.new()

var tab_button_normal_stylebox : StyleBoxFlat = StyleBoxFlat.new()
var tab_button_hover_stylebox : StyleBoxFlat = StyleBoxFlat.new()
var tab_button_pressed_stylebox : StyleBoxFlat = StyleBoxFlat.new()
var close_button_normal_stylebox : StyleBoxFlat = StyleBoxFlat.new()
var close_button_hover_stylebox : StyleBoxFlat = StyleBoxFlat.new()
var close_button_pressed_stylebox : StyleBoxFlat = StyleBoxFlat.new()



func kill_stuff():
	remove_type(thing_to_kill)

func stylebox_setup(state : String, name : String, stylebox : StyleBox):
	stylebox.border_color = accent_color
	set_stylebox(state, name, stylebox)


@export var font_color : Color = Color(1.0, 1.0, 1.0, 1.0):
	set(value):
		font_color = value
		set_color("font_color", "Button", value)
		set_color("font_hover_color", "Button", value)
		set_color("font_hover_pressed_color", "Button", value)
		set_color("font_pressed_color", "Button", value)
		set_color("font_pressed_color", "Button", value)
		set_color("default_color", "RichTextLabel", value)
		set_color("font_color", "Label", value)
		set_color("font_color", "FoldableContainer", value)
		set_color("collapsed_font_color", "FoldableContainer", value)
		set_color("hover_font_color", "FoldableContainer", value)
		set_color("font_color", "LineEdit", value)

@export var accent_color : Color = Color(1.0, 1.0, 1.0, 1.0):
	set(value):
		accent_color = value
		line_stylebox.bg_color = value
		stylebox_setup("panel", "Line", line_stylebox)

@export var background_panel : StyleBox:
	set(value):
		background_panel = value
		set_stylebox("panel", "Panel", value)
@export var background_panel_2 : StyleBox:
	set(value):
		background_panel_2 = value
		set_stylebox("panel", "Panel2", value)
		set_stylebox("normal", "RichTextLabel", value)
		set_stylebox("normal", "LineEdit", value)


@export var progress_bar_background : StyleBox:
	set(value):
		progress_bar_background = value
		set_stylebox("background", "ProgressBar", value)
@export var progress_bar : StyleBox:
	set(value):
		progress_bar = value
		set_stylebox("fill", "ProgressBar", value)


@export var tab_button_normal : Color = Color(1.0, 1.0, 1.0, 1.0):
	set(value):
		tab_button_normal = value
		tab_button_normal_stylebox.bg_color = value
		tab_button_normal_stylebox.border_color = accent_color
		stylebox_setup("normal", "TabButton", tab_button_normal_stylebox)
@export var tab_button_hover : Color = Color(1.0, 1.0, 1.0, 1.0):
	set(value):
		tab_button_hover = value
		tab_button_hover_stylebox.bg_color = value
		tab_button_hover_stylebox.border_color = accent_color
		tab_button_hover_stylebox.border_width_left = 2
		stylebox_setup("hover", "TabButton", tab_button_hover_stylebox)
@export var tab_button_pressed : Color = Color(1.0, 1.0, 1.0, 1.0):
	set(value):
		tab_button_pressed = value
		tab_button_pressed_stylebox.bg_color = value
		tab_button_pressed_stylebox.border_color = accent_color
		tab_button_pressed_stylebox.border_width_left = 2
		stylebox_setup("pressed", "TabButton", tab_button_pressed_stylebox)

@export var close_button_normal : Color = Color(1.0, 1.0, 1.0, 1.0):
	set(value):
		close_button_normal = value
		close_button_normal_stylebox.bg_color = value
		close_button_normal_stylebox.border_color = accent_color
		stylebox_setup("normal", "Button", close_button_normal_stylebox)
		set_stylebox("title_collapsed_panel", "FoldableContainer", close_button_normal_stylebox)
		set_stylebox("title_collapsed_hover_panel", "FoldableContainer", close_button_normal_stylebox)
@export var close_button_hover : Color = Color(1.0, 1.0, 1.0, 1.0):
	set(value):
		close_button_hover = value
		close_button_hover_stylebox.bg_color = value
		close_button_hover_stylebox.border_color = accent_color
		stylebox_setup("hover", "Button", close_button_hover_stylebox)
		set_stylebox("title_hover", "FoldableContainer", close_button_hover_stylebox)
@export var close_button_pressed : Color = Color(1.0, 1.0, 1.0, 1.0):
	set(value):
		close_button_pressed = value
		close_button_pressed_stylebox.bg_color = value
		close_button_pressed_stylebox.border_color = accent_color
		stylebox_setup("pressed", "Button", close_button_pressed_stylebox)
		set_stylebox("panel", "FoldableContainer", close_button_pressed_stylebox)
		set_stylebox("title_panel", "FoldableContainer", close_button_pressed_stylebox)


@export var slider : StyleBoxLine:
	set(value):
		slider = value
		set_stylebox("grabber", "HScrollBar", value)
		set_stylebox("slider", "HSlider", value)
		value.vertical = true
		
		set_stylebox("grabber", "VScrollBar", value)
		set_stylebox("slider", "VSlider", value)
@export var slider_hover : StyleBoxLine:
	set(value):
		slider_hover = value
		set_stylebox("grabber_highlight", "HScrollBar", value)
		value.vertical = true
		
		set_stylebox("grabber_highlight", "VScrollBar", value)
@export var slider_pressed : StyleBoxLine:
	set(value):
		slider_pressed = value
		set_stylebox("grabber_pressed", "HScrollBar", value)
		value.vertical = true
		
		set_stylebox("grabber_pressed", "VScrollBar", value)
@export var slider_background : StyleBoxLine:
	set(value):
		slider_background = value
		
		set_stylebox("scroll", "HScrollBar", value)
		set_stylebox("slider", "HSlider", value)
		set_stylebox("grabber_area", "HSlider", value)
		set_stylebox("grabber_area_highlight", "HSlider", value)
		value.vertical = true
		
		set_stylebox("scroll", "VScrollBar", value)
		set_stylebox("slider", "VSlider", value)
		set_stylebox("grabber_area", "HSlider", value)
		set_stylebox("grabber_area_highlight", "HSlider", value)
		
@export var scroll_icon : Texture2D:
	set(value):
		scroll_icon = value
		set_icon("grabber", "HSlider", value)
		set_icon("grabber_highlight", "HSlider", value)
