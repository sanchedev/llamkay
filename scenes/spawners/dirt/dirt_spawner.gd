extends StaticBody3D

@export var seed: Items.ITEMS_LIST
@onready var marker_3d: Marker3D = $Marker3D
@onready var timer: Timer = $Timer

func plant():
	var scene = Plants.seeds.get(seed)
	if scene == null: return
	
	var plant: Plant = scene.instantiate()
	marker_3d.add_child(plant)


func _on_marker_3d_child_exiting_tree(node: Node) -> void:
	timer.start()


func _on_timer_timeout() -> void:
	plant()
