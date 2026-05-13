extends Control

func _ready():
	$Panel/VBoxContainer/ResumeButton.pressed.connect(GameManager.toggle_pause)
	$Panel/VBoxContainer/MenuButton.pressed.connect(GameManager.back_to_menu)
