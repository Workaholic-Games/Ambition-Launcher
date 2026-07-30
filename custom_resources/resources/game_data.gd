extends Resource
class_name GameData

@export_subgroup("Info")
@export var name : String
@export_multiline() var description : String
@export var age_rating : String
@export var difficulty : String
@export var stability : String
@export var release_data : String

@export_subgroup("Media")
@export var cover : Texture2D
@export var font_size : int = 16
@export var images : Array[Texture2D]
@export var videos : Array[VideoStream]
@export var installable : bool = true

@export_subgroup("Installation")
@export var version_names : PackedStringArray
@export var version_links_windows : PackedStringArray
@export var version_links_mac : PackedStringArray
@export var version_links_linux : PackedStringArray
@export var version_file_names_windows : PackedStringArray
@export var version_file_names_mac : PackedStringArray
@export var version_file_names_linux : PackedStringArray
@export var folder_path : String
@export var save_data_folder_name : PackedStringArray
