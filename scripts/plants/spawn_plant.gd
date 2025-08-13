class_name SpawnPlant extends StaticBody3D

@export var complete_plant: Plant

@export var pickable_area: Area3D
@export var outline: Node3D
@export var item_markers: Array[Items.ITEMS_LIST]
@export var markers: Node3D

var selected = false

func _ready() -> void:
	get_tree().get_first_node_in_group("player").interact_object.connect(_on_player_interact_object)

func _process(delta: float) -> void:
	outline.visible = selected
	for collision in pickable_area.get_children():
		if collision is CollisionShape3D:
			collision.disabled = not visible
	
	if selected and Input.is_action_just_pressed("pick") and visible:
		var nodes = markers.get_children()
		
		var idx = 0
		for marker in nodes:
			var instance: Pickable = Items.get_item(item_markers[idx]).pickable_scene.instantiate()
			instance.position = marker.global_position
			instance.rotation = marker.global_rotation
			get_tree().get_first_node_in_group("world").add_child(instance)
			instance.apply_impulse(Vector3(0,2,0))
			idx += 1
		
		complete_plant.queue_free()

func _on_player_interact_object(collider):
	selected = collider == pickable_area
