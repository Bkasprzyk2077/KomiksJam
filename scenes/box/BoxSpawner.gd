extends Area2D

@export var box_scene: PackedScene

			
@warning_ignore("unused_parameter")
func _physics_process(delta):
	if get_tree().get_first_node_in_group("player"):
		if overlaps_body(get_tree().get_first_node_in_group("player")):
			if Input.is_action_just_pressed("interact"):
				spawn_box()


func spawn_box():
	var box_scene_instance = box_scene.instantiate()
	get_parent().add_child(box_scene_instance)
	box_scene_instance.global_position = $SpawnPosition.global_position
	
