extends CharacterBody2D
class_name PBullet

var SPEED = 600.0
var destroyed = false

func _physics_process(delta):
	move_and_collide(velocity * delta)

func set_direction(direction):
	velocity = direction * SPEED

func set_speed(factor):
	SPEED *= factor

func destroy():
	if !destroyed:
		destroyed = true
		call_deferred("free")

func _on_body_entered(body):
	print('TOUCHED')	
	if body != self:
		if "Bullet" in body.name:
			print('DESTROY')
			body.destroy()
		
