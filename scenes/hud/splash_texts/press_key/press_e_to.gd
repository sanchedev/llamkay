extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var button: Button = $Button

@export var text: String = "" : set = _set_text

signal asked_for_action()

func _set_text(value: String):
	text = value
	$RichTextLabel.text = "[center]Presiona [b]E[/b] para\n" + value.to_lower()
	$Button.text = value

func _ready() -> void:
	_set_text(text)
	if DisplayServer.is_touchscreen_available():
		button.visible = true
		rich_text_label.visible = false
	else:
		button.visible = false
		rich_text_label.visible = true

func _process(delta: float) -> void:
	if visible and Input.is_action_just_pressed("action"):
		asked_for_action.emit()

func _on_button_pressed() -> void:
	asked_for_action.emit()
