extends Node

@onready var dialog_panel_scene = preload("res://ui/dialog_panel.tscn")
var dialog_canvas

func _ready():
	pass

func start_dialog(dialog_text_file):
	dialog_canvas = get_tree().get_first_node_in_group("dialog_canvas")
	var dialog_panel_instance = dialog_panel_scene.instantiate()
	dialog_canvas.add_child(dialog_panel_instance)
	await dialog_panel_instance.get_node("AnimationPlayer").animation_finished
	dialog_panel_instance.set_up_text(dialog_text_file)
	

