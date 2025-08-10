class_name InHand extends Node3D

@export var item: Items.ITEMS_LIST

func _ready() -> void:
	if item == null or item == Items.ITEMS_LIST.NONE: push_error("The null or item none arent a item and should not be use like a common item.")
