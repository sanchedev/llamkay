extends PanelContainer

@onready var touch_screen_button: TouchScreenButton = $TouchScreenButton

const NORMAL = preload("res://assets/hud/buttons/building_mode/normal.png")
const ACTIVE = preload("res://assets/hud/buttons/building_mode/active.png")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("building_mode"):
		BuildingController.is_building_mode_active = !BuildingController.is_building_mode_active
	touch_screen_button.texture_normal = NORMAL if not BuildingController.is_building_mode_active else ACTIVE
