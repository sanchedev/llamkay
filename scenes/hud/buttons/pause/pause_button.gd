class_name PauseButton extends TextureButton

func _on_pressed() -> void:
	PauseController.instance.pause()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('pause'):
		if !PauseController.instance.get_paused(): PauseController.instance.pause()
