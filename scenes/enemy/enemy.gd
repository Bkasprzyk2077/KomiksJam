extends RigidBody2D

@onready var death_area = $DeathArea
@export var speed = 200

var current_moon
var moon_direction
var move_direction = 1

func _physics_process(delta):
	if get_tree().get_first_node_in_group("player"):
		if death_area.overlaps_body(get_tree().get_first_node_in_group("player")):
			death()
	if current_moon:
		moon_direction = global_position.direction_to(current_moon.global_position)
		rotation = deg_to_rad(rad_to_deg(moon_direction.angle()) - 90)
	else:
		moon_direction = Vector2.ZERO
		
	set_axis_velocity(moon_direction.rotated(deg_to_rad(85 * -move_direction)) * speed)


func death():
	var player = get_tree().get_first_node_in_group("player")
	player.apply_impulse(-moon_direction * 300)
	GameEvents.emit_enemy_killed()
	queue_free()




func _on_player_kicker_body_entered(body):
	move_direction *= -1
	$PlayerKicker.scale.x *= -1
	$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
	var player = get_tree().get_first_node_in_group("player")
	if body == player:
		player.apply_impulse(global_position.direction_to(player.global_position) * 1000)
