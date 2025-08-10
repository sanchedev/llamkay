class_name PauseMenu extends Control

@export var pause_btn: PauseButton

func _ready() -> void:
	hide()
	pause_btn.pause.connect(_on_pause)

func _on_pause():
	show()

func _on_resume_button_pressed() -> void:
	PauseController.instance.resume()
	hide()
