class_name InventoryManager extends Node

@export var inventory_res: InventoryRes

var all_items: Array[InventorySlotRes] = [] : set = _set_all_items, get = _get_all_items

func _set_all_items(value: Array[InventorySlotRes]):
	all_items = value

func _get_all_items():
	return inventory_res.all_items

static var instance: InventoryManager

signal slot_changed(idx: int, slot: InventorySlotRes, old_item: Items.ITEMS_LIST, old_count: int)

func _ready() -> void:
	self.instance = self
	all_items = inventory_res.all_items

static func get_item_at(idx: int) -> InventorySlotRes:
	return InventoryManager.instance.all_items[idx]

static func set_item_at(idx: int, item: Items.ITEMS_LIST, count: int) -> void:
	var old_item = InventoryManager.instance.all_items[idx].item
	var old_count = InventoryManager.instance.all_items[idx].count
	var new_item = item if count > 0 else Items.ITEMS_LIST.NONE
	var new_count = count if count > 0 else 0
	
	InventoryManager.instance.all_items[idx].item = new_item
	InventoryManager.instance.all_items[idx].count = new_count
	InventoryManager.instance.slot_changed.emit(idx, get_item_at(idx), old_item, old_count)
