extends CanvasLayer


func _on_play_button_pressed():
	SceneTransition.change_scene("res://levels/level0.tscn")


func _on_play_button_2_pressed():
	get_tree().quit()
