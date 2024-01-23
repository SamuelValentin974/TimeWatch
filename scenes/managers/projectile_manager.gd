class_name ProjectileManager
extends Node2D

@onready var base_bullet_scene : PackedScene = preload("res://scenes/Bullet.tscn")

func _ready():
	SignalBus.connect("fire", build_projectile)
	
func build_projectile(ressource : ProjectileBaseRessource, location: Vector2, direction : Vector2) -> void:
	var new_bullet = base_bullet_scene.instantiate() as Bullet
	
	new_bullet.sprite_2d = ressource.projectile_sprite
	new_bullet.position = location
	new_bullet.direction = (direction - global_position).normalized()
	new_bullet.rotation = new_bullet.direction.angle()
	new_bullet.speed = ressource.projectile_speed * Global.speed_factor

	spawn_projectile(new_bullet)
	
func spawn_projectile(bullet : Bullet) -> void:
	var projectile_container = NodeExtensions.get_projectile_container()
	
	if projectile_container == null:
		return
	projectile_container.add_child(bullet)

