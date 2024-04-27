extends Node2D

@export var box_count_to_kick: int = 1
var box_count_current: int = 0

func _on_box_catcher_body_entered(body):
	if body.is_in_group("box"):
		box_count_current += 1
		body.queue_free()
		if box_count_to_kick >= box_count_to_kick:
			all_boxes_kicked()

func all_boxes_kicked():
	print("ALL boxes colected")
	DialogManager.start_dialog("res://dialogs/dialog1.txt")
