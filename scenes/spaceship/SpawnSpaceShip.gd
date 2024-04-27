extends PathFollow2D

var points_to_visit = []
var next_point
var spawned_player = false

@export var player_scene: PackedScene
@export var spawn_player_ratio: float = .5
@export var speed: float = 200

func _process(delta):
	if progress_ratio >= spawn_player_ratio and !spawned_player:
		spawned_player = true
		spawn_player()
	if progress_ratio < 0.95: 
		progress += delta * speed
	else:
		queue_free()
		return


func spawn_player():
	if get_tree().get_first_node_in_group("player"):
		return
	var player_instance = player_scene.instantiate()
	get_parent().get_parent().add_child(player_instance)
	player_instance.global_position = $Sprite2D.global_position
	$Sprite2D/Camera2D.enabled = false
