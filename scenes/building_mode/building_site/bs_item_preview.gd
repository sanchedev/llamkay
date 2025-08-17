class_name BSItemPreview extends MeshInstance3D

@export var item: Items.ITEMS_LIST
@export var count: int

@onready var bs_item_preview: MeshInstance3D = $"."


func _ready() -> void:
	var item_obj: Item = Items.get_item(item)
	var plane: PlaneMesh = PlaneMesh.new()
	plane.size.x = 1.0
	plane.size.y = 1.0
	var material = StandardMaterial3D.new()
	material.albedo_texture = item_obj.texture
	material.albedo_texture_force_srgb = true
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	plane.material = material
	bs_item_preview.mesh = plane
	# TODO: Make the shader
	
