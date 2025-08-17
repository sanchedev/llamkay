extends StructureNode

@export var allowed_item: Array[Items.ITEMS_LIST] = []

@onready var player_detector: Area3D = $Area3D
@onready var press_e_to: Control = $Area3D/CanvasLayer/PressETo
@onready var markers: Node3D = $Markers


func _process(delta: float) -> void:
	if check_player_with_item():
		press_e_to.show()
	else:
		press_e_to.hide()


func _on_press_e_to_asked_for_action() -> void:
	if not check_player_with_item(): return
	var player = player_detector.get_overlapping_bodies()[0]
	var item: InventorySlotRes = player.get_hand_item()
	plant(item.item)
	InventoryManager.set_item_at(31, item.item, item.count - 5)

func check_player_with_item() -> bool:
	if not player_detector.has_overlapping_bodies(): return false
	var player = player_detector.get_overlapping_bodies()[0]
	if not (player is Player): return false
	var item: InventorySlotRes = player.get_hand_item()
	if not allowed_item.has(item.item) or item.count < 5: return false
	if markers.get_children().any(func(marker): return marker.get_child_count() > 0): return false
	return true


func plant(item: Items.ITEMS_LIST):
	var markers_plant = markers.get_children()
	
	var scene = Plants.seeds.get(item)
	if scene == null: return
	for marker in markers_plant:
		var plant: Plant = scene.instantiate()
		marker.add_child(plant)
