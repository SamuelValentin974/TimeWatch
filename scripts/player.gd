extends CharacterBody2D
class_name Player

@onready var dash = $Dash
@onready var sprite = $sprite
@onready var attack_timer = $AttackTimer
@onready var ultime_timer = $UltimeTimer

@export var Bullet : PackedScene

const dash_speed = 40000
const move_speed = 9000
var speed = 0
const dash_duration = 0.2
var is_attacking = false
var ult = false
var can_attack = true

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()

	if Input.is_action_just_pressed("dash") and dash.can_dash and !dash.is_dashing() and !is_attacking:
		dash.start_dash(sprite, dash_duration)
		can_attack = true

	if Input.is_action_just_pressed("shoot") and can_attack and velocity.x != 0:
		can_attack = false
		is_attacking = true
		attack_timer.start()
		var bullet = Bullet.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = global_position + (50 * direction)
		if ult:
			bullet.set_speed(Global.speed_factor)
		else:
			bullet.set_speed(1)
		bullet.set_direction(direction)
		
	speed = dash_speed if dash.is_dashing() else move_speed
	sprite.play()
	
	if Input.is_action_just_pressed("special") and !ult:
		print("CASTING ULTIMATE")
		ult = true
		ultime_timer.start()

	velocity = direction * speed * delta
	move_and_slide()

	if is_attacking:
		sprite.animation = "shoot"
	elif dash.is_dashing():
		sprite.animation = "dash"
	elif velocity.x != 0:
		sprite.animation = "run"
		sprite.flip_h = velocity.x < 0
	elif  velocity.x == 0:
		sprite.animation = "idle"

func _on_shooting_timeout():
	is_attacking = false
	can_attack = true

func _on_ultime_timer_timeout():
	ult = false
