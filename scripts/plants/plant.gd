class_name Plant extends Node3D

@export var phases_durantion_in_sec: Array[int] = []

var current_index: int = 0

func _ready() -> void:
	var nodes = self.get_children()
	for node in nodes:
		node.hide()
	
	nodes.get(0).show()

var counter: float = 0
func _process(delta: float) -> void:
	counter += delta
	
	if counter >= phases_durantion_in_sec[current_index]:
		self.get_child(current_index).hide()
		current_index += 1
		if get_child_count() >= current_index:
			self.queue_free()
		else:
			self.get_child(current_index).show()
	
