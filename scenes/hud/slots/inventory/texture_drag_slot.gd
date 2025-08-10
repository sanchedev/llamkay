class_name TextureDragSlot extends TextureRect

var index: int = 0

func _get_drag_data(at_position: Vector2) -> int:
	if InventoryManager.get_item_at(index).item == Items.ITEMS_LIST.NONE: return -1
	
	var preview_texture: TextureRect = self.duplicate()
	preview_texture.position = position - at_position
	
	var preview: Control = Control.new()
	preview.add_child(preview_texture)
	preview.z_index = 2
	
	set_drag_preview(preview)
	
	return index

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is int and data < InventoryManager.instance.all_items.size() and data >= 0

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if not (data is int) and data >= InventoryManager.instance.all_items.size() or data < 0: return
	
	var inv_slot = InventoryManager.get_item_at(data)
	var item_1 = inv_slot.item
	var count_1 = inv_slot.count
	
	var my_inv_slot = InventoryManager.get_item_at(index)
	
	if my_inv_slot.item != item_1:
		InventoryManager.set_item_at(data, my_inv_slot.item, my_inv_slot.count)
		InventoryManager.set_item_at(index, item_1, count_1)
	else:
		var item_info = Items.get_item(item_1)
		var count = count_1 + my_inv_slot.count
		var overflow = count - item_info.max_count
		InventoryManager.set_item_at(index, my_inv_slot.item, min(count, item_info.max_count))
		if overflow <= 0:
			InventoryManager.set_item_at(data, Items.ITEMS_LIST.NONE, 0)
		else:
			InventoryManager.set_item_at(data, item_1, overflow)
