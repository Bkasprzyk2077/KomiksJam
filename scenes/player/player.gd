extends RigidBody2D

@onready var sprite_2d = $AnimatedSprite2D
@export var jump_force = 500
@onready var kick_shape = $BoxKickArea/CollisionShape2D
@onready var progress_bar = $CrystalDetectorCanvas/VBoxContainer/ProgressBar


var current_moon
var moon_direction

func _ready():
	GameEvents.connect("player_death", death)

@warning_ignore("unused_parameter")
func _physics_process(delta):
	zoom()
	animate()
	switch_camera()
	detect_crystal()
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
	if !current_moon:
		sprite_2d.play("fly")
	elif !$FloorDetect.overlaps_body(current_moon):
		sprite_2d.play("fly")
	elif abs(linear_velocity) <= Vector2(.05,.05):
		sprite_2d.play("idle")
	else:
		sprite_2d.play("run")
		
	if Input.is_action_just_pressed("left"):
		sprite_2d.flip_h = true
		$BoxKickArea.position.x = -138
	elif Input.is_action_just_pressed("right"):
		sprite_2d.flip_h = false
		$BoxKickArea.position.x = 138

func detect_crystal():
	var closest_crystal = find_closest_or_furthest(self, "hidden_crystal")
	if closest_crystal:
		var distance = global_position.distance_to(closest_crystal.global_position)
		if distance < 1000:
			$CrystalDetectorCanvas/VBoxContainer.visible = true
		else:
			$CrystalDetectorCanvas/VBoxContainer.visible = false
		progress_bar.value = 1000 - distance
	else:
		$CrystalDetectorCanvas/VBoxContainer.visible = false
		

func find_closest_or_furthest(node: Object, group_name: String, get_closest:= true) -> Object:
	var target_group = get_tree().get_nodes_in_group(group_name)
	if !target_group:
		return
	var distance_away = node.global_transform.origin.distance_to(target_group[0].global_transform.origin)
	var return_node = target_group[0]
	for index in target_group.size():
		var distance = node.global_transform.origin.distance_to(target_group[index].global_transform.origin)
		if get_closest == true && distance < distance_away:
			distance_away = distance
			return_node = target_group[index]
		elif get_closest == false && distance > distance_away:
			distance_away = distance
			return_node = target_group[index]
	return return_node
	
func switch_camera():
	if Input.is_action_just_pressed("camera_switch"):
		$Camera2D.ignore_rotation = !$Camera2D.ignore_rotation


func zoom():
	if Input.is_action_just_released('wheel_down'):
		$Camera2D.zoom.x += 0.25
		$Camera2D.zoom.y += 0.25
	if Input.is_action_just_released('wheel_up') and $Camera2D.zoom.x > .5 and $Camera2D.zoom.y > .5:
		$Camera2D.zoom.x -= 0.25
		$Camera2D.zoom.y -= 0.25

func _on_box_kick_area_body_entered(body):
	if body.is_in_group("box"):
		body.apply_impulse(global_position.direction_to($BoxKickArea/KickDirection.global_position)*100)


func death():
	SceneTransition.reload_scene()
	

func _on_death_timer_timeout():
	death()
