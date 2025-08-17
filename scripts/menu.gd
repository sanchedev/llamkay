class_name Menu extends Control

var parent_node: MenuControl

func enter(parent: MenuControl):
	parent_node = parent
	parent.add_child(self)
	PauseController.instance.pause()

## Not use this out the self
func exit():
	_exit()
	queue_free()
	PauseController.instance.resume()
	parent_node.current = ""

func _exit():
	pass

## It's for ask for close the menu.
func ask_for_exit():
	exit()
