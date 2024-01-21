extends Node2D

@onready var duration_timer = $durationTimer
@onready var ghost_timer = $GhostTimer

const dash_delay = 0.5
var ghost_scn = preload("res://scenes/DashGhost.tscn")

var can_dash = true
var sprite

func start_dash(newSprite, duration):
	self.sprite = newSprite
	duration_timer.wait_time = duration
	duration_timer.start()
	ghost_timer.start()
	instance_ghost()

func instance_ghost():
	var ghost: Sprite2D = ghost_scn.instantiate()
	get_parent().get_parent().add_child(ghost)

	ghost.global_position = global_position
	ghost.flip_h = sprite.flip_h

func is_dashing():
	return !duration_timer.is_stopped()

func end_dash():
	ghost_timer.stop()
	can_dash = false
	await get_tree().create_timer(dash_delay).timeout
	can_dash = true

func _on_duration_timer_timeout():
	end_dash()

func _on_ghost_timer_timeout():
	instance_ghost()
