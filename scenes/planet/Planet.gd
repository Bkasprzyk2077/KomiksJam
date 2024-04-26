extends StaticBody2D


func _on_gravity_area_body_entered(body):
	if "current_moon" in body:
		body.current_moon = self


func _on_gravity_area_body_exited(body):
	if "current_moon" in body:
		if body.current_moon == self:
			body.current_moon = null
