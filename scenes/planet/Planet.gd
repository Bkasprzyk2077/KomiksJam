extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Gravity_area.gravity_point_unit_distance = $Gravity_area/CollisionShape2D.shape.radius / 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gravity_area_body_entered(body):
	if "current_moon" in body:
		body.current_moon = self


func _on_gravity_area_body_exited(body):
	if "current_moon" in body:
		if body.current_moon == self:
			body.current_moon = null
