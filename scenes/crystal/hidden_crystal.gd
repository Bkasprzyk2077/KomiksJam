extends Node2D

@onready var area_2d = $Area2D

func _process(delta):
	if !get_tree().get_first_node_in_group("player"):
		return
	if area_2d.overlaps_body(get_tree().get_first_node_in_group("player")):
		if Input.is_action_just_pressed("interact"):
			$Sprite2D.visible = true
			$Sprite2D.play("dig")
			await $Sprite2D.animation_finished
			GameEvents.emit_crystal_gather()
			queue_free()
