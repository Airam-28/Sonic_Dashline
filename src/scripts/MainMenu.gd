extends Control

func _ready():
	get_tree().paused = false
	$UI/VBoxContainer/Buttons/StartButton.pressed.connect(GameManager.start_game)
	$UI/VBoxContainer/Buttons/OptionsButton.pressed.connect(_on_options_button_pressed)
	$UI/VBoxContainer/Buttons/QuitButton.pressed.connect(_on_quit_button_pressed)

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://src/ui/OptionsMenu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
