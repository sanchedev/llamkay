class_name PauseController extends Node3D

signal change_pause_state(paused: bool)

var change = ""

func pause():
	if change == "": change = "pause"

func resume():
	if change == "": change = "resume"

func get_paused():
	return get_tree().paused

static var instance: PauseController

func _ready() -> void:
	instance = self

func _process(delta: float) -> void:
	if change == "pause":
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		change_pause_state.emit(true)
	elif change == "resume":
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		change_pause_state.emit(false)
	
	if change != "":
		change = ""
	pass
