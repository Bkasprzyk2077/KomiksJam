extends CanvasLayer


func _on_play_button_pressed():
	SceneTransition.change_scene("res://ui/IntroPanel.tscn")


func _on_play_button_2_pressed():
	get_tree().quit()


func _on_level_0_pressed():
	SceneTransition.change_scene("res://levels/level0.tscn")


func _on_level_1_pressed():
	SceneTransition.change_scene("res://levels/level1.tscn")
	


func _on_level_2_pressed():
	SceneTransition.change_scene("res://levels/level2.tscn")
