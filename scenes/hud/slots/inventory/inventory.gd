class_name Inventory extends Menu


func _on_close_button_pressed() -> void:
	ask_for_exit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		ask_for_exit()

func ask_for_exit():
	exit()
