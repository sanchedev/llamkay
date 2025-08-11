class_name Player
extends CharacterBody3D

@export var speed = 4
@export var run_speed = 7
@export var mouse_sensitivity = 0.004

@onready var camera = $Camera3D
@onready var ray_cast_3d: RayCast3D = $Camera3D/RayCast3D
@onready var player_item_slot: PlayerItemSlot = $ItemSlot


signal interact_object(collider)
signal change_current_object(item: Items.ITEMS_LIST, count: int)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var is_running = false

# Movement
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	instance = self

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	is_running = Input.is_action_pressed("run") and HealthController.food_bar >= 10
	
	var current_speed = speed
	if is_running: current_speed = run_speed
	
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	if input_dir != Vector2.ZERO:
		if is_running:
			HealthController.use_food_to_run(delta)
		else:
			HealthController.use_food_to_walk(delta)
	
	move_and_slide()

func _process(delta: float) -> void:
	if ray_cast_3d.is_colliding():
		var collider: Node3D = ray_cast_3d.get_collider()
		
		if collider == null: return
		
		if not (collider is Pickable):
			interact_object.emit(collider)
			return
		
		var pickable_item: Pickable = collider
		var item_slot = get_hand_item()
		if item_slot.item != Items.ITEMS_LIST.NONE:
			if item_slot.count >= Items.get_item(item_slot.item).max_count: return
			if pickable_item.item != item_slot.item: return
		
		interact_object.emit(pickable_item)
		
		if Input.is_action_just_pressed("pick"):
			var count = item_slot.count+1 if pickable_item.item == get_hand_item().item else 1
			set_hand_item(pickable_item.item, count)
			pickable_item.queue_free()
	else:
		interact_object.emit(null)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera.rotation.x -= event.relative.y * mouse_sensitivity
		rotation.y -= event.relative.x * mouse_sensitivity
		
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-45), deg_to_rad(60))
	
	if event.is_action_pressed("drop") and get_hand_item().item != Items.ITEMS_LIST.NONE:
		drop_item()

static var instance: Player

func drop_item():
	var item_slot = get_hand_item()
	
	var count = item_slot.count - 1
	var item = item_slot.item
	
	if count <= 0:
		item = Items.ITEMS_LIST.NONE
		count = 0
	
	player_item_slot.drop()
	
	set_hand_item(item, count)

func set_hand_item(new_item: Items.ITEMS_LIST, new_count: int):
	InventoryManager.set_item_at(31, new_item, new_count)

func get_hand_item() -> InventorySlotRes:
	return InventoryManager.get_item_at(31)
