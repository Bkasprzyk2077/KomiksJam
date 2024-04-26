extends Node2D



func _on_area_2d_body_entered(body):
	if body == get_tree().get_first_node_in_group("player"):
		body.current_moon = null
