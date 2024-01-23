extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_bt_quit_pressed():
		get_tree().quit()


func _on_bt_play_pressed():
	get_tree().change_scene_to_file("res://scene/level_1.tscn")

