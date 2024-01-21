class_name PlayerEntity
extends CharacterBody2D

@onready var dash = $Dash
@onready var sprite = $sprite
@onready var fire_timer = $AttackTimer
@onready var ultime_timer = $UltimeTimer

@export var fire_rate : float = 0.2
@export var projectile_ressource : ProjectileBaseRessource = null

const dash_speed = 40000
const move_speed = 9000
var speed = 0
const dash_duration = 0.2
var is_attacking = false
var can_ult = false
var can_fire = true

func _ready():
	fire_timer.connect("timeout", set_can_fire)
	ultime_timer.connect("timeout", set_can_ult)
	fire_timer.wait_time = fire_rate
	
func _process(_delta):
	dashing()

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	fire_projectile(direction)
	cast_ultimate()	

	if direction:
		speed = dash_speed if dash.is_dashing() else move_speed
	else:
		speed = Vector2.ZERO
	sprite.play()

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
		
func dashing() -> void:
	if Input.is_action_just_pressed("dash") and dash.can_dash and !dash.is_dashing() and !is_attacking:
		dash.start_dash(sprite, dash_duration)
		can_fire = true
		print("DASHING")

func cast_ultimate() -> void:
	if Input.is_action_just_pressed("ultime") and can_ult and !is_attacking:
		can_ult = false
		ultime_timer.start()
		print("ULTIMATE")
		Global.speed_factor = 0.3

func fire_projectile(direction : Vector2) -> void:
	if Input.is_action_just_pressed("fire") and can_fire and velocity.x != 0:
		can_fire = false
		fire_timer.start()
		is_attacking = true
		print("BANG")
		SignalBus.emit_fire(projectile_ressource, position + (velocity / 3), direction)

func set_can_fire() -> void:
	can_fire = true
	is_attacking = false

func set_can_ult() -> void:
	can_ult = true
	Global.speed_factor = 1
