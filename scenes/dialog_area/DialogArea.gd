extends Area2D

@export var dialog_text_file: String




func _on_body_entered(body):
	if get_tree().get_first_node_in_group("dialog_canvas").get_child_count():
		return
	if body == get_tree().get_first_node_in_group("player"):
		DialogManager.start_dialog(dialog_text_file)
		queue_free()
