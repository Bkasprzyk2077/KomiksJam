extends RigidBody2D

@onready var sprite_2d = $AnimatedSprite2D
@export var jump_power = 300

var current_moon
var moon_direction

func _physics_process(delta):
	#animate()
	if current_moon:
		moon_direction = global_position.direction_to(current_moon.global_position)
		rotation = deg_to_rad(rad_to_deg(moon_direction.angle()) - 90)
	else:
		moon_direction = Vector2.ZERO
		
	var move_direction = Input.get_axis("left", "right")
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		set_axis_velocity(moon_direction.rotated(deg_to_rad(85 * -move_direction)) * 400)
			

	if Input.is_action_just_pressed("up"):
		print("TEST")
		if $FloorDetect.overlaps_body(current_moon):
			apply_impulse(-moon_direction * jump_power)
	
	
func animate():
	if !$FloorDetect.overlaps_body(current_moon):
		sprite_2d.play("fly")
	elif abs(linear_velocity) <= Vector2(.05,.05):
		sprite_2d.play("idle")
	else:
		sprite_2d.play("run")
	
	
	if Input.is_action_just_pressed("left"):
		sprite_2d.flip_h = true
	elif Input.is_action_just_pressed("right"):
		sprite_2d.flip_h = false
