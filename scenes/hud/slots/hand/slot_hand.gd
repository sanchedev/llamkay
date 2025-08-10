class_name SlotHand extends TextureButton

var item = null : set = _set_item

const NO_ITEM = preload("res://assets/hud/items/no_item.png")

@onready var texture_rect: TextureRect = $TextureRect
@onready var item_name: PanelContainer = $ItemName
@onready var item_count: PanelContainer = $ItemCount
@onready var progress_bar: ProgressBar = $ProgressBar


func _set_item(value):
	if value == null:
		$PanelContainer/Label.text = ""
		$TextureRect.texture = NO_ITEM
		$PanelContainer.hide()
	else:
		$PanelContainer/Label.text = value.name
		$TextureRect.texture = value.texture
		$PanelContainer.show()

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
		item_name.get_child(0).text = item_obj.item_name
		item_count.get_child(0).text = "x"+str(slot.count)
		progress_bar.value = slot.count*100/item_obj.max_count
