extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$CenterPanel/VBoxContainer/ScoreInfo.text = "Rings Collected: " + str(GameManager.rings)
	$CenterPanel/VBoxContainer/Buttons/RestartButton.pressed.connect(GameManager.start_game)
	$CenterPanel/VBoxContainer/Buttons/MenuButton.pressed.connect(GameManager.back_to_menu)
