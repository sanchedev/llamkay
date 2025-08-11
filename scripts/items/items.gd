class_name Items

enum ITEMS_LIST {
	NONE,
	ROCK,
	CORN,
}

static var _items: Dictionary = {
	ITEMS_LIST.NONE: Item.new(
		"Nada xdxdxd",
		preload("res://assets/hud/items/no_item.png"),
		preload("res://scenes/items/rock/rock_pickable.tscn"),
		preload("res://scenes/items/rock/rock_in_hand.tscn"),
		1
	),
	ITEMS_LIST.ROCK: Item.new(
		"Roca",
		preload("res://assets/hud/items/rock.png"),
		preload("res://scenes/items/rock/rock_pickable.tscn"),
		preload("res://scenes/items/rock/rock_in_hand.tscn"),
		8
	),
	ITEMS_LIST.CORN: Item.new(
		"Maiz",
		preload("res://assets/hud/items/corn.png"),
		preload("res://scenes/items/corn/corn_pickable.tscn"),
		preload("res://scenes/items/corn/corn_in_hand.tscn"),
		8
	),
}

static func get_item(item: ITEMS_LIST) -> Item:
	return _items.get(item)
