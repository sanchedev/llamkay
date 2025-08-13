class_name Inventory extends Menu

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var animating: bool = false

func _ready() -> void:
	animating = true
	animation_player.play("fade_in")

func _on_close_button_pressed() -> void:
	if animating: return
	ask_for_exit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and !animating:
		ask_for_exit()

func ask_for_exit():
	animating = true
	animation_player.play("fade_out")
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animating = false
	if anim_name == "fade_out":
		exit()
