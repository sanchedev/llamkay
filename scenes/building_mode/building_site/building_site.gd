class_name BuildingSite extends Area3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var press_e_to: Control = $CanvasLayer/PressETo

const STRUCTURE_SELECTOR = preload("res://scenes/hud/menus/structure_selector/structure_selector.tscn")

static var building_here: BuildingSite

@onready var player = get_tree().get_first_node_in_group("player") as Player
@onready var items: Node3D = $Items
@onready var rotator: Node3D = $Items/Rotator
@onready var items_detector: Area3D = $ItemsDetector

var current_structure = null

func _process(delta: float) -> void:
	visible = BuildingController.is_building_mode_active
	collision_shape_3d.disabled = not BuildingController.is_building_mode_active
	
	if items.visible:
		items.look_at(player.position)
		items.rotation.x = PI/2
		items.rotation.z = 0
		

func _on_body_entered(body: Node3D) -> void:
	if body is Player: press_e_to.visible = true


func _on_body_exited(body: Node3D) -> void:
	if body is Player: press_e_to.visible = false


func _on_press_e_to_asked_for_action() -> void:
	building_here = self
	get_tree().get_first_node_in_group("screen").ask_for_screen("structure_selector", STRUCTURE_SELECTOR)
	pass

const BS_ITEM_PREVIEW = preload("res://scenes/building_mode/building_site/bs_item_preview.tscn")
func select_structure(structure: Structures.STRUCTURES_LIST):
	items.show()
	current_structure = structure
	
	for n in rotator.get_children():
		n.queue_free()
	var structure_obj: Structure = Structures.get_structure(structure)
	
	var frame_size = 1.0
	var gap = 0.25
	var length = structure_obj.materials.size()
	var size = length*frame_size + (length-1)*gap
	var margin = frame_size/2
	print(margin, size / 2)
	for item in structure_obj.materials.keys():
		var str_item = BS_ITEM_PREVIEW.instantiate()
		str_item.item = item
		str_item.count = structure_obj.materials[item]
		str_item.position.x = margin - size / 2
		rotator.add_child(str_item)
		margin += length + gap


func _on_items_detector_body_entered(body: Node3D) -> void:
	if current_structure == null: return
	
	var dict: Dictionary = {}
	
	var all_items = items_detector.get_overlapping_bodies()
	for item_pickable in all_items:
		if item_pickable is Pickable:
			dict.set(item_pickable.item, dict.get(item_pickable.item, 0)+1)
	
	var structure_obj: Structure = Structures.get_structure(current_structure)
	
	var materials = structure_obj.materials
	var is_ = true
	
	for item in materials.keys():
		is_ = is_ and (dict.get(item, 0) >= materials.get(item, 0))
		
		if not is_: break
	
	if is_:
		var stru = structure_obj.scene.instantiate()
		get_parent().add_child(stru)
		stru.position = position
		stru.rotation = rotation
		queue_free()
		
		for n in all_items:
			n.queue_free()
