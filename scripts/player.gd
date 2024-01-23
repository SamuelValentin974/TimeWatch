extends CharacterBody2D
class_name Player

signal took_damage
signal healthChanged

@onready var dash = $Dash
@onready var sprite = $sprite
@onready var fire_timer = $AttackTimer
@onready var ultime_timer = $UltimeTimer

@onready var max_health = 100
@onready var current_health: int = max_health

@export var fire_rate : float = 0.2
@export var projectile_ressource : ProjectileBaseRessource = null
@export var audio : AudioStream

const dash_speed = 35000
const move_speed = 9000
var speed = 0
const dash_duration = 0.2
var is_active = true
var is_attacking = false
var can_ult = true
var can_fire = true
var up = Vector2(0,-1)
var down = Vector2(0,1)
var left = Vector2(-1,0)
var right = Vector2(1,0)
var lives : int = 5
var is_invincible = false

func _ready():
	fire_timer.connect("timeout", set_can_fire)
	ultime_timer.connect("timeout", set_can_ult)
	fire_timer.wait_time = fire_rate
	
func _process(_delta):
	dashing()

func _physics_process(delta):
	if is_active:
		var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
		fire_projectile(direction)
		cast_ultimate()

		if direction:
			speed = dash_speed if dash.is_dashing() else move_speed
		else:
			speed = Vector2.ZERO
		velocity = direction * speed * delta
		move_and_slide()
		sprite.play()
		if is_attacking and velocity.x == 0:
			sprite.animation = "shoot_up" if direction == up else "snipe"
			AudioManager.shoot.play()
		elif is_attacking and velocity.x != 0:
			sprite.animation = "shoot"
			AudioManager.shoot.play()
		elif dash.is_dashing():
			sprite.animation = "dash"
		elif velocity.x != 0:
			sprite.animation = "run"
			sprite.flip_h = velocity.x < 0
		elif  velocity.x == 0:
			sprite.animation = "idle"
		
func dashing() -> void:
	if Input.is_action_just_pressed("dash") and dash.can_dash and !dash.is_dashing() and !is_attacking:
		AudioManager.dash.play()
		dash.start_dash(sprite, dash_duration)
		can_fire = true
		print("DASHING")

func cast_ultimate() -> void:
	if Input.is_action_just_pressed("special") and can_ult:
		AudioManager.ult.play()
		can_ult = false
		can_fire = false
		ultime_timer.start()
		print("ULTIMATE")
		Global.speed_factor = 0.3

func fire_projectile(direction : Vector2) -> void:
	if Input.is_action_just_pressed("shoot") and can_fire:
		can_fire = false
		can_ult = false
		fire_timer.start()
		is_attacking = true
		print("BANG")
		if direction:
			SignalBus.emit_fire(projectile_ressource, position + (velocity / 2.5), direction)
		else:
			direction = left if sprite.flip_h else right
			SignalBus.emit_fire(projectile_ressource, position + (Vector2(-50,-5) if sprite.flip_h else Vector2(50,-5)), direction)

func set_can_fire() -> void:
	can_fire = true
	can_ult = true
	is_attacking = false

func set_can_ult() -> void:
	can_ult = true
	can_fire = true
	Global.speed_factor = 1
	
func take_hit():
	if !is_invincible:
		lives -= 1
		sprite.play("hurt")
		is_invincible = true
		emit_signal("took_damage")
		await get_tree().create_timer(1).timeout
		is_invincible = false
	
func get_lives():
	return lives
	
func set_active(actived : bool):
	is_active = actived

func set_invincible(actived : bool):
	is_invincible = actived
