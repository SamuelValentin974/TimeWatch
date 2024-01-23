extends Node2D

@export var _nextScene : PackedScene = null
@export var _isFinalLevel: bool = false

@onready var player = $Player
@onready var UI = $UiLayer
@onready var HUD = $UiLayer/HUD

func _ready():
	HUD.set_lives(player.get_lives())	

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
				player.set_invincible(true)
				player.set_active(false)
				UI.set_win_screen(true)
			else:
				get_tree().change_scene_to_packed(_nextScene)

func _on_player_took_damage():
	HUD.set_lives(player.get_lives())
	if player.get_lives() <= 0:
		player.set_invincible(true)
		player.set_active(false)
		UI.setLoseScreen(true)
