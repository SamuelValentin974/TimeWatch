extends Control

@onready var label_lives = $LivesLabel

func set_lives(lives):
	label_lives.text = "Lives : " + str(lives)
