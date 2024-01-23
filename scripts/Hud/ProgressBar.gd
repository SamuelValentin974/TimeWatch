extends TextureProgressBar

@export var player : PlayerEntity

func  _ready():
	player.healthChanged.connect(update)
	update()

func  update():
	value = player.current_health * 100 / player.max_health
