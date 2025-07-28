class_name PauseController extends Node3D

func pause():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func resume():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_paused():
	return get_tree().paused

static var instance: PauseController

func _ready() -> void:
	instance = self
