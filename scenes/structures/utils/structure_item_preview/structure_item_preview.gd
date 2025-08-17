class_name StructureItemPreview
extends PanelContainer

@export var item: Items.ITEMS_LIST
@export var count: int

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $TextureRect/Label


func _ready() -> void:
	var item_obj: Item = Items.get_item(item)
	texture_rect.texture = item_obj.texture
	label.text = str(count)
