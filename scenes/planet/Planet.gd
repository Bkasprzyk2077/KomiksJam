extends StaticBody2D

var i = 0

	
func _on_gravity_area_body_entered(body):
	if "current_moon" in body:
		body.current_moon = self
		if body.has_node("DeathTimer"):
			body.get_node("DeathTimer").stop()


func _on_gravity_area_body_exited(body):
	if "current_moon" in body:
		if body.current_moon == self:
			body.current_moon = null
			if body.has_node("DeathTimer"):
				body.get_node("DeathTimer").start()
