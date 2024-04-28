extends Node2D

@export var box_count_to_kick: int = 1
var box_count_current: int = 0

func _on_box_catcher_body_entered(body):
	if body.is_in_group("box"):
		box_count_current += 1
		body.queue_free()
		if box_count_current >= box_count_to_kick:
			all_boxes_kicked()

func all_boxes_kicked():
	get_parent().current_task_count += 1
	$BoxCatcher/CollisionShape2D.disabled = true
	DialogManager.start_dialog("res://dialogs/task_end_boxes.txt")
	if get_parent().current_task_count >= get_parent().task_count:
		GameEvents.emit_call_escape_ship()
		get_parent().flip_planets()
