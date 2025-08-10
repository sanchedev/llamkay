class_name PauseButton extends TextureButton

signal pause()

func _on_pressed() -> void:
	if !PauseController.instance.get_paused():
		PauseController.instance.pause()
		pause.emit()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('pause'):
		if !PauseController.instance.get_paused():
			PauseController.instance.pause()
			pause.emit()
