class_name Structures extends Node

enum STRUCTURES_LIST {
	BASIC_PLANTING_LAND,
}

static var structures_obj: Dictionary[STRUCTURES_LIST, Structure] = {
	STRUCTURES_LIST.BASIC_PLANTING_LAND: Structure.new(
		"BASIC_PLANTING_LAND",
		preload("res://assets/hud/structures/preview/basic_planting_land/gigant.png"),
		{
			Items.ITEMS_LIST.ROCK: 10
		},
		preload("res://scenes/structures/basic_planting_land/basic_planting_land.tscn"),
	)
}

static func get_structure(structure: STRUCTURES_LIST) -> Structure:
	return structures_obj.get(structure)
