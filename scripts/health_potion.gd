extends Area2D

@onready var text = $RichTextLabel
var playerNear = false

# Called when the node enters the scene tree for the first time.
func _ready():
	text.visible = false # Replace with function body.
	
func _process(delta):
	if Input.is_action_just_pressed("pickup") && playerNear:
			queue_free()

func _on_body_entered(body):
	if body is Player:
		text.visible = true
		playerNear = true


func _on_body_exited(body):
	if text.visible:
		text.visible = false
		playerNear = false
