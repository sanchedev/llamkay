class_name InventorySlot extends PanelContainer

@export var am_i_main_hand = false

@onready var texture_drag_slot: TextureDragSlot = $TextureDragSlot
@onready var label: Label = $TextureDragSlot/Label

const NO_ITEM = preload("res://assets/hud/items/no_item.png")

var index: int

var current_item: Items.ITEMS_LIST
var current_count: int

func _ready() -> void:
	if am_i_main_hand:
		var style = StyleBoxFlat.new()
		style.bg_color = Color("e9d160")
		style.corner_radius_bottom_left = 8
		style.corner_radius_top_left = 8
		style.corner_radius_bottom_right = 8
		style.corner_radius_top_right = 8
		set("theme_override_styles/panel", style)
	
	index = get_index()
	texture_drag_slot.index = index
	
	reload()

func _process(delta: float) -> void:
	reload()

func reload():
	var item_slot = InventoryManager.get_item_at(index)
	
	if current_item == item_slot.item and current_count == item_slot.count: return
	
	current_item = item_slot.item
	current_count = item_slot.count
	
	if current_item == Items.ITEMS_LIST.NONE:
		texture_drag_slot.texture = NO_ITEM
		label.hide()
		label.text = ""
	else:
		texture_drag_slot.texture = Items.get_item(current_item).texture
		label.show()
		label.text = "x"+str(current_count)
