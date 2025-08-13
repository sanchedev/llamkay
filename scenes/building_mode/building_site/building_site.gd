class_name BuildingSite extends Area3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var press_e_to: Control = $CanvasLayer/PressETo

func _process(delta: float) -> void:
	visible = BuildingController.is_building_mode_active
	collision_shape_3d.disabled = not BuildingController.is_building_mode_active

func _on_body_entered(body: Node3D) -> void:
	if body is Player: press_e_to.visible = true


func _on_body_exited(body: Node3D) -> void:
	if body is Player: press_e_to.visible = false


func _on_press_e_to_asked_for_action() -> void:
	# get_tree().get_first_node_in_group("screen").ask_for_screen("inventory", INVENTORY)
	pass
