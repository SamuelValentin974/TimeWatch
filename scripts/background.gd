extends ParallaxBackground

var scroll_speed = 15

@onready var bg1 = $ParallaxLayer/bg1
@onready var bg2 = $ParallaxLayer/bg2
@onready var bg3 = $ParallaxLayer/bg3
@onready var bg4 = $ParallaxLayer/bg4
@onready var bg5 = $ParallaxLayer/bg5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bg1.region_rect.position += delta  * Vector2(30, 0)
	bg2.region_rect.position += delta  * Vector2(25, 0)
	bg3.region_rect.position += delta  * Vector2(15, 0)
	bg4.region_rect.position += delta  * Vector2(10, 0)
	bg5.region_rect.position += delta  * Vector2(5, 0)
