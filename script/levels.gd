extends Node2D

@export var _nextScene : PackedScene = null
@export var _isFinalLevel: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_next_zone_body_entered(body):
	if body is Player:
		if _isFinalLevel || (_nextScene != null):
			if _isFinalLevel:
				get_tree().quit()
			else:
				get_tree().change_scene_to_packed(_nextScene)
