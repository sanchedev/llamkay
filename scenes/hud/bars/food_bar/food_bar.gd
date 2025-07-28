class_name FoodBarProgress extends TextureProgressBar

func _process(delta: float) -> void:
	value = ceil(HealthController.food_bar/10)
