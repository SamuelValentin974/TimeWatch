extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collision = $Col
var Chasing : bool = false
var player = null
var life : int = 3
@export var speed = 1

func _physics_process(delta):
	if Chasing:
		position += (player.position - position) / speed * delta


func _on_area_2d_body_entered(body):
	if body is Player:
		player = body
		Chasing = true
		sprite.play("run")

func _on_bullet_area_body_entered(body):
	if body is Bullet:
		body.queue_free()
		if life > 1:
			life -= 1
		else:
			collision.disabled = true
			sprite.play("death")
			await get_tree().create_timer(0.75).timeout
			queue_free()
	elif body is Player:
		body.take_hit()
	
