class_name StructureSelector extends Menu

var current_structure = null

@onready var buttons_container: GridContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/VBoxContainer/GridContainer

@onready var info_panel: PanelContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer
@onready var info_panel_title: Label = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Label
@onready var info_panel_desc: RichTextLabel = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/RichTextLabel
@onready var info_panel_items: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/ScrollContainer2/HBoxContainer
@onready var info_panel_button: Button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/VBoxContainer/Button

const STRUCTURE_ITEM_PREVIEW = preload("res://scenes/structures/utils/structure_item_preview/structure_item_preview.tscn")

var building_site: BuildingSite

func _ready() -> void:
	building_site = BuildingSite.building_here
	
	for node in buttons_container.get_children():
		if node is StructureButtonSelector:
			node.structure_selected.connect(_on_structure_selected)
	
	if building_site.current_structure != null:
		_on_structure_selected(building_site.current_structure)

func _on_close_button_pressed() -> void:
	ask_for_exit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		ask_for_exit()

func ask_for_exit():
	BuildingSite.building_here = null
	exit()


func _on_structure_selected(structure: Structures.STRUCTURES_LIST):
	if structure == current_structure:
		current_structure = null
		info_panel.hide()
		return
	
	current_structure = structure
	var structure_obj: Structure = Structures.get_structure(structure)
	info_panel.show()
	info_panel_title.text = structure_obj.name
	info_panel_desc.text = structure_obj.description
	info_panel_button.disabled = current_structure == building_site.current_structure
	
	for node in info_panel_items.get_children():
		node.queue_free()
	
	for item in structure_obj.materials.keys():
		var str_item = STRUCTURE_ITEM_PREVIEW.instantiate()
		str_item.item = item
		str_item.count = structure_obj.materials[item]
		info_panel_items.add_child(str_item)


func _on_button_pressed() -> void:
	if current_structure == null: return
	
	building_site.select_structure(current_structure)
	ask_for_exit()
