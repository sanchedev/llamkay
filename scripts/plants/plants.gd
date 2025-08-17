class_name Plants

static var seeds: Dictionary[Items.ITEMS_LIST, PackedScene] = {
	Items.ITEMS_LIST.CORN: preload("res://scenes/plants/corn/corn_plant.tscn"),
	Items.ITEMS_LIST.CASSAVA_STICK: preload("res://scenes/plants/cassava/cassava_plant.tscn")
}
