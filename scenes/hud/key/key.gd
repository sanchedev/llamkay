@tool
class_name Key extends TextureRect

@export var label: String = "" : set = _set_label

func _set_label(value):
	$Label.text = value
	label = value
