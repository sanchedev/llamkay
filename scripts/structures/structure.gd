class_name Structure

var name: String
var description: String
var thumbnail: Texture
var materials: Dictionary[Items.ITEMS_LIST, int]
var scene: PackedScene


func _init(
	key: String,
	thumbnail: Texture,
	materials: Dictionary[Items.ITEMS_LIST, int],
	scene: PackedScene
) -> void:
	self.name = "STRUCTURE."+key+".NAME"
	self.thumbnail = thumbnail
	self.description = "STRUCTURE."+key+".DESC"
	self.materials = materials
	self.scene = scene
