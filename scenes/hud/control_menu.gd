class_name MenuControl extends Control

const INVENTORY = preload("res://scenes/hud/slots/inventory/inventory.tscn")

var current: String = ""

func _process(delta: float) -> void:
	if current == "":
		if Input.is_action_just_pressed("inventory"):
			var inv = INVENTORY.instantiate()
			inv.enter(self)
