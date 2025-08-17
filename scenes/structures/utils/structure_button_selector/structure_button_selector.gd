class_name StructureButtonSelector extends TextureButton

@export var structure: Structures.STRUCTURES_LIST

signal structure_selected(structure: Structures.STRUCTURES_LIST)

func _on_pressed() -> void:
	structure_selected.emit(structure)
