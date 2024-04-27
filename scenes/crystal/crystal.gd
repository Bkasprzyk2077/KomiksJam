extends Node2D

@onready var area_2d = $Area2D
@onready var animation_player = $AnimationPlayer

func _ready():
	$Sprite2D.texture = load(["res://assets/crystals/k1.png", "res://assets/crystals/k2.png", "res://assets/crystals/k3.png", "res://assets/crystals/k4.png", "res://assets/crystals/k5.png"].pick_random())

func _process(delta):
	if get_tree().get_first_node_in_group("player"):
		if area_2d.overlaps_body(get_tree().get_first_node_in_group("player")):
			if Input.is_action_just_pressed("interact"):
				$Area2D/CollisionShape2D.disabled = true
				GameEvents.emit_crystal_gather()
				animation_player.play("mine")
