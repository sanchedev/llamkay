class_name Inventory extends Menu

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var animating: bool = false

func _enter():
	show()
	animating = true
	animation_player.play("fade_in")

func _exit():
	animating = true
	animation_player.play("fade_out")

func _on_close_button_pressed() -> void:
	if animating: return
	exit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and !animating:
		exit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animating = false
	if anim_name == "fade_out":
		hide()
		_end_exit()
