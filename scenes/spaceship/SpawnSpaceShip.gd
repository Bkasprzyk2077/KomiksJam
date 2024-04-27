extends PathFollow2D

var points_to_visit = []
var next_point

@export var speed: float = 200
@onready var path_follow_2d = $Path2D/PathFollow2D

func _process(delta):
	print(progress_ratio)
	if progress_ratio < 0.95: 
		progress += delta * speed
	else:
		queue_free()
		return
