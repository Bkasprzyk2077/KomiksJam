extends CanvasLayer


func _on_play_button_pressed():
	SceneTransition.change_scene("res://ui/IntroPanel.tscn")


func _on_play_button_2_pressed():
	get_tree().quit()
