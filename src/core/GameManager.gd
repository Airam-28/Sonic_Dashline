extends Node

signal rings_changed(count)
signal boost_changed(amount)

var rings: int = 0:
	set(value):
		rings = value
		rings_changed.emit(rings)

var boost: float = 100.0:
	set(value):
		boost = clampf(value, 0.0, 100.0)
		boost_changed.emit(boost)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("ui_cancel") and get_tree().current_scene.name == "World":
		toggle_pause()

func toggle_pause():
	var pause_menu = get_tree().current_scene.find_child("PauseMenu", true, false)
	if pause_menu:
		get_tree().paused = !get_tree().paused
		pause_menu.visible = get_tree().paused

func start_game():
	rings = 0
	boost = 100.0
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_file", "res://src/levels/World.tscn")

func win_game():
	get_tree().paused = true
	get_tree().call_deferred("change_scene_to_file", "res://src/ui/WinScreen.tscn")

func lose_game():
	get_tree().paused = true
	get_tree().call_deferred("change_scene_to_file", "res://src/ui/GameOver.tscn")

func back_to_menu():
	get_tree().paused = false
	rings = 0
	boost = 100.0
	get_tree().call_deferred("change_scene_to_file", "res://src/ui/MainMenu.tscn")
