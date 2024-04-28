extends Area2D

@export var lore: PackedScene
@export var images: Array


func _on_body_entered(body):
	if get_tree().get_first_node_in_group("dialog_canvas").get_child_count():
		return
	if body == get_tree().get_first_node_in_group("player"):
		var lore_instance = lore.instantiate()
		lore_instance.images = images
		get_parent().add_child(lore_instance)
		queue_free()
