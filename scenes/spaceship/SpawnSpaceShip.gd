extends Node2D

var points_to_visit = []
var next_point

@export var speed: float = 200

func _ready():
	points_to_visit = $Points.get_children()
	print(points_to_visit)
	next_point = get_next_point()
	
func _process(delta):
	move_to_point(delta)
	
func move_to_point(delta):
	if global_position == next_point:
		next_point = get_next_point()
	else:
		global_position = global_position.move_toward(next_point, delta * speed)

func get_next_point():
	var point = points_to_visit.pop_front()
	if point == null:
		queue_free()
		return
	return point.global_position
