extends AnimatableBody2D

@export var radius = 500
@export var speed: float = .5
@export var d: float = 0

func _physics_process(delta):
	d += delta
	position = Vector2(
		sin(d * speed) * radius,
		cos(d * speed) * radius
	)
	var moon_direction = global_position.direction_to(get_parent().global_position)
	rotation = deg_to_rad(rad_to_deg(moon_direction.angle()) - 90)
