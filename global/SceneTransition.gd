extends Node2D

@onready var animation_player = $AnimationPlayer


func change_scene(new_scene: String) -> void:
	get_tree().paused = true
	animation_player.play("FadeToBlack")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(new_scene)
	animation_player.play("FadeFromBlack")
	get_tree().paused = false
	
func reload_scene():
	get_tree().paused = true
	animation_player.play("FadeToBlack")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	animation_player.play("FadeFromBlack")
	get_tree().paused = false
