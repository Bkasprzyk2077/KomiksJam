extends Node2D

@onready var area_2d = $Area2D

func _process(delta):
	if area_2d.overlaps_body(get_tree().get_first_node_in_group("player")):
		if Input.is_action_just_pressed("interact"):
			GameEvents.emit_crystal_gather()
			queue_free()