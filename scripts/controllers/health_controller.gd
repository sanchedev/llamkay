class_name HealthController

static var food_bar = 100
static var health_bar = 100

static var full_bar = 100

static func use_food_to_walk(delta: float):
	food_bar -= delta/9

static func use_food_to_run(delta: float):
	food_bar -= delta/2

static func use_food_to_regenerate():
	pass
