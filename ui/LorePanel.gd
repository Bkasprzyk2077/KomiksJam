extends CanvasLayer

@export var images: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	next_image()


func next_image():
	if images:
		$AnimationPlayer.play("next")
	else:
		get_tree().paused = false
		SceneTransition.change_scene("res://levels/level0.tscn")

func change_img():
	$TextureRect.texture = load(images.pop_front())

func _on_timer_timeout():
	next_image()
