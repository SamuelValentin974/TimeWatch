extends CharacterBody2D
class_name Bullet

@onready var sprite_2d = $Sprite2D as Sprite2D
@onready var visible_notifier = $VisibleNotifier as VisibleOnScreenNotifier2D
@onready var death_timer = $DeathTimer as Timer

var direction : Vector2 = Vector2.RIGHT
var speed = 600.0
var damage : float = 0.0

func  _process(delta):
	move(delta)

func move(delta: float) -> void:
	move_and_collide(direction * delta * speed)

func set_speed(factor):
	speed *= factor

func _on_visible_notifier_screen_exited():
	death_timer.start(0.8)

func _on_death_timer_timeout():
	queue_free()
