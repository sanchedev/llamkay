class_name HealthBarProgress extends TextureRect

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var label: Label = $TextureProgressBar/Label

var value: int = 100 : set = _set_value

func _set_value(value: int):
	texture_progress_bar.value = value
	label.text = str(value)

func _process(delta: float) -> void:
	value = ceil(HealthController.health_bar)
