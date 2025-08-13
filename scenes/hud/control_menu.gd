class_name MenuControl extends Control

var current: String = ""

func ask_for_screen(key: String, screen: PackedScene):
	if current != "": return false
	if get_child_count() > 0: return
	
	var scr = screen.instantiate()
	scr.enter(self)
	current = key
