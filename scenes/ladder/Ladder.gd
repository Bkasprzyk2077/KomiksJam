extends Node2D

@onready var area_2d = $Area2D
@onready var start = $Start
@onready var end = $End

func _physics_process(delta):
	if area_2d.overlaps_body(get_tree().get_first_node_in_group("player")):
		var player = get_tree().get_first_node_in_group("player")
		if Input.is_action_pressed("up"):
			var direction_to_end = global_position.direction_to(end.global_position)
			player.set_axis_velocity(direction_to_end*100)
		elif Input.is_action_pressed("down"):
			var direction_to_start = global_position.direction_to(start.global_position)
			player.set_axis_velocity(direction_to_start*100)
