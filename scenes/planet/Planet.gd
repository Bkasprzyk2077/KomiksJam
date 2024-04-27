extends StaticBody2D

var i = 0


func _physics_process(delta):
	$Sprite2.rotation += delta/8
	$Sprite3.rotation += delta/10
	
func _on_gravity_area_body_entered(body):
	if "current_moon" in body:
		body.current_moon = self


func _on_gravity_area_body_exited(body):
	if "current_moon" in body:
		if body.current_moon == self:
			body.current_moon = null
