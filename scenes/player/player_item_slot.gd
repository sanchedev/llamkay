class_name PlayerItemSlot extends Marker3D

func _ready() -> void:
	InventoryManager.instance.slot_changed.connect(_on_slot_changed)

func _on_slot_changed(idx: int, slot: InventorySlotRes, old_item: Items.ITEMS_LIST, old_count: int):
	if idx != 31: return
	
	if get_child_count() > 0:
		var item_scene: InHand = get_child(0)
		
		if item_scene.item == slot.item: return
		
		item_scene.queue_free()
	
	if slot.item == Items.ITEMS_LIST.NONE: return
	
	var item_pickable_scene = Items.get_item(slot.item).in_hand_scene.instantiate()
	add_child(item_pickable_scene)

func drop():
	var pickable_scene: Pickable = Items.get_item(InventoryManager.get_item_at(31).item).pickable_scene.instantiate() as Pickable
	
	get_tree().get_first_node_in_group("world").add_child(pickable_scene)
	pickable_scene.global_rotation = global_rotation
	pickable_scene.global_position = global_position
	
	pickable_scene.apply_impulse(to_global(Vector3(0, 2, -2)) - global_position)
