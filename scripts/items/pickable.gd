class_name Pickable extends CharacterBody3D

var selected = false
@export var outline: Node3D
@export var item: Items.ITEMS_LIST

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	get_tree().get_first_node_in_group("player").interact_object.connect(_on_player_interact_object)
	if item == null or item == Items.ITEMS_LIST.NONE: push_error("The null or item none arent a item and should not be use like a common item.")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()

func _process(delta: float) -> void:
	outline.visible = selected

func _on_player_interact_object(collider):
	selected = collider == self
