extends Control

func _on_bt_replay_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_bt_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu_game.tscn")

func _on_bt_quit_pressed():
		get_tree().quit()
