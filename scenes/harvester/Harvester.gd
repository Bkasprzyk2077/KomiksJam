extends Area2D

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D


func _process(delta):
	if get_tree().get_first_node_in_group("player"):
		if overlaps_body(get_tree().get_first_node_in_group("player")):
			if Input.is_action_just_pressed("interact"):
				sprite_2d.visible = true
				collision_shape_2d.disabled = true
				GameEvents.emit_crystal_gather()
				DialogManager.start_dialog("res://dialogs/shattered_1.txt")
