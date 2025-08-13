extends PanelContainer

const INVENTORY = preload("res://scenes/hud/slots/inventory/inventory.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		get_tree().get_first_node_in_group("screen").ask_for_screen("inventory", INVENTORY)
