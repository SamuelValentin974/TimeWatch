extends Node2D

@onready var show_text = $RichTextLabel

func _ready():
	show_text.visible = false

func _on_detect_area_body_entered(body):
	if body is Player:
		show_text.visible = true


func _on_detect_area_body_exited(body):
	if body is Player:
		show_text.visible = false
