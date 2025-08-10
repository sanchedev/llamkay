class_name Menu extends Control

var parent_node: Node

var is_ready = false
func _ready() -> void:
	_enter()
	is_ready = true

func enter(parent: Node):
	parent_node = parent
	parent.add_child(self)
	PauseController.instance.pause()
	

func exit():
	_exit()

func _enter():
	pass

func _exit():
	pass
func _end_exit():
	parent_node.remove_child(self)
	PauseController.instance.resume()

func _enter_tree() -> void:
	if is_ready: _enter()
