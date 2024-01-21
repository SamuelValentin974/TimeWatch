extends StaticBody2D

var life : int = 3

func _on_area_2d_body_entered(body):
	if body is PBullet:
		body.queue_free()
		if life > 1:
			life -= 1
		else:
			queue_free()
