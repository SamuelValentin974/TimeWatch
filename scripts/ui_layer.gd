extends CanvasLayer

@onready var _loseScreen = $LoseScreen
@onready var _winScreen = $WinScreen

func setLoseScreen(flag : bool):
	_loseScreen.visible = flag
	
func set_win_screen(flag : bool):
	_winScreen.visible = flag
