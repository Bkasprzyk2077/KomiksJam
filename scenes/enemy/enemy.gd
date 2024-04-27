extends RigidBody2D

@onready var death_area = $DeathArea


var current_moon
var moon_direction

func _physics_process(delta):
	if death_area.overlaps_body(get_tree().get_first_node_in_group("player")):
		death()
	if current_moon:
		moon_direction = global_position.direction_to(current_moon.global_position)
		rotation = deg_to_rad(rad_to_deg(moon_direction.angle()) - 90)
	else:
		moon_direction = Vector2.ZERO
		
	var move_direction = 1
	set_axis_velocity(moon_direction.rotated(deg_to_rad(85 * -move_direction)) * 300)


func death():
	var player = get_tree().get_first_node_in_group("player")
	player.apply_impulse(-moon_direction * 1000)
	queue_free()
