extends PathFollow2D

var points_to_visit = []
var next_point
var can_go = false

@export var exit_ratio: float = .5
@export var speed: float = 300
@export var next_level: String

func _ready():
	GameEvents.connect('call_escape_ship', on_call_escape_ship)

func _process(delta):
	if !can_go:
		return
	if progress_ratio >= exit_ratio and get_tree().get_first_node_in_group("player"):
		speed = 0
	if progress_ratio < 0.95: 
		progress += delta * speed
	else:
		SceneTransition.change_scene(next_level)
		return


func _on_area_2d_body_entered(body):
	if body == get_tree().get_first_node_in_group("player"):
		$Sprite2D/Camera2D.enabled = true
		body.queue_free()
		speed = 300


func on_call_escape_ship():
	can_go = true
