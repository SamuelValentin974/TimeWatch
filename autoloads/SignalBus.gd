extends Node

signal fire(ressource : ProjectileBaseRessource, location: Vector2, direction : Vector2)

func emit_fire(ressource : ProjectileBaseRessource, location: Vector2, direction : Vector2):
	fire.emit(ressource, location, direction)
