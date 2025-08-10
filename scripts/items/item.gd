class_name Item

var item_name: String
var texture: Texture2D
var pickable_scene: PackedScene
var in_hand_scene: PackedScene
var max_count: int

func _init(item_name: String, texture: Texture2D, pickable_scene: PackedScene, in_hand_scene: PackedScene, max_count: int) -> void:
	self.item_name = item_name
	self.texture = texture
	self.pickable_scene = pickable_scene
	self.in_hand_scene = in_hand_scene
	self.max_count = max_count
