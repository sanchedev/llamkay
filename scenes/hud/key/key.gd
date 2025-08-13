@tool
class_name Key extends TextureRect

@export var label: String = "" : set = _set_label

func _ready() -> void:
	visible = not DisplayServer.is_touchscreen_available()

func _set_label(value):
	$Label.text = value
	label = value
