class_name SlotHand extends TextureButton

const NO_ITEM = preload("res://assets/hud/items/no_item.png")

@onready var texture_rect: TextureRect = $TextureRect
@onready var item_name: PanelContainer = $ItemName
@onready var item_count: PanelContainer = $ItemCount
@onready var progress_bar: ProgressBar = $ProgressBar


func _ready() -> void:
	InventoryManager.instance.slot_changed.connect(_on_slot_changed)


func _on_slot_changed(idx: int, slot: InventorySlotRes, old_item: Items.ITEMS_LIST, old_count: int):
	if idx != 31: return
	
	if slot.item == Items.ITEMS_LIST.NONE:
		texture_rect.texture = NO_ITEM
		item_name.hide()
		item_count.hide()
		progress_bar.hide()
	else:
		var item_obj = Items.get_item(slot.item)
		texture_rect.texture = item_obj.texture
		item_name.show()
		item_count.show()
		progress_bar.show()
		item_name.get_child(0).text = tr(item_obj.item_name)
		item_count.get_child(0).text = str(slot.count)
		progress_bar.value = slot.count*100/item_obj.max_count
