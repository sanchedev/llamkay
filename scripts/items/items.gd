class_name Items

enum ITEMS_LIST {
	NONE,
	ROCK,
	CORN,
	CASSAVA,
	CASSAVA_STICK,
	POTATO,
}

static var _items: Dictionary = {
	ITEMS_LIST.NONE: Item.new(
		"ITEM.NONE",
		preload("res://assets/hud/items/no_item.png"),
		preload("res://scenes/items/rock/rock_pickable.tscn"),
		preload("res://scenes/items/rock/rock_in_hand.tscn"),
		1
	),
	ITEMS_LIST.ROCK: Item.new(
		"ITEM.ROCK",
		preload("res://assets/hud/items/rock.png"),
		preload("res://scenes/items/rock/rock_pickable.tscn"),
		preload("res://scenes/items/rock/rock_in_hand.tscn"),
		8
	),
	ITEMS_LIST.CORN: Item.new(
		"ITEM.CORN",
		preload("res://assets/hud/items/corn.png"),
		preload("res://scenes/items/corn/corn_pickable.tscn"),
		preload("res://scenes/items/corn/corn_in_hand.tscn"),
		8
	),
	ITEMS_LIST.CASSAVA: Item.new(
		"ITEM.CASSAVA",
		preload("res://assets/hud/items/cassava.png"),
		preload("res://scenes/items/cassava/cassava_pickable.tscn"),
		preload("res://scenes/items/cassava/cassava_in_hand.tscn"),
		4
	),
	ITEMS_LIST.CASSAVA_STICK: Item.new(
		"ITEM.CASSAVA_STICK",
		preload("res://assets/hud/items/cassava_stick.png"),
		preload("res://scenes/items/cassava_stick/cassava_stick_pickable.tscn"),
		preload("res://scenes/items/cassava_stick/cassava_stick_in_hand.tscn"),
		6
	),
	ITEMS_LIST.POTATO: Item.new(
		"ITEM.POTATO",
		preload("res://assets/hud/items/cassava.png"),
		preload("res://scenes/items/potato/potato_pickable.tscn"),
		preload("res://scenes/items/potato/potato_in_hand.tscn"),
		6
	)
}

static func get_item(item: ITEMS_LIST) -> Item:
	return _items.get(item)
