extends RigidBody2D

@onready var sprite_2d = $AnimatedSprite2D
@export var jump_force = 500
@onready var kick_shape = $BoxKickArea/CollisionShape2D


var current_moon
var moon_direction

@warning_ignore("unused_parameter")
func _physics_process(delta):
	#animate()
	if Input.is_action_pressed("interact"):
		kick_shape.disabled = false
	else:
		kick_shape.disabled = true
	if current_moon:
		moon_direction = global_position.direction_to(current_moon.global_position)
		rotation = deg_to_rad(rad_to_deg(moon_direction.angle()) - 90)
	else:
		moon_direction = Vector2.ZERO
		
	var move_direction = Input.get_axis("left", "right")
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		set_axis_velocity(moon_direction.rotated(deg_to_rad(85 * -move_direction)) * 400)
			

	if Input.is_action_just_pressed("up"):
		var overlapng_bodies = $FloorDetect.get_overlapping_bodies()
		overlapng_bodies.erase(self)
		if overlapng_bodies:
			apply_impulse(-moon_direction * jump_force)
	
	
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


func _on_box_kick_area_body_entered(body):
	if body.is_in_group("box"):
		body.apply_impulse(global_position.direction_to($BoxKickArea/KickDirection.global_position)*100)
