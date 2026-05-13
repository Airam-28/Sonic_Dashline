extends Control

func _ready():
	$VBoxContainer/ScrollContainer/OptionsList/Fullscreen/CheckButton.toggled.connect(_on_fullscreen_toggled)
	$VBoxContainer/ScrollContainer/OptionsList/MasterVolume/Slider.value_changed.connect(func(v): _set_volume("Master", v))
	$VBoxContainer/ScrollContainer/OptionsList/MusicVolume/Slider.value_changed.connect(func(v): _set_volume("Music", v))
	$VBoxContainer/ScrollContainer/OptionsList/SFXVolume/Slider.value_changed.connect(func(v): _set_volume("SFX", v))
	$VBoxContainer/BackButton.pressed.connect(GameManager.back_to_menu)
	
	var is_full = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN or DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	$VBoxContainer/ScrollContainer/OptionsList/Fullscreen/CheckButton.button_pressed = is_full
	
	_sync_slider("Master", $VBoxContainer/ScrollContainer/OptionsList/MasterVolume/Slider)
	_sync_slider("Music", $VBoxContainer/ScrollContainer/OptionsList/MusicVolume/Slider)
	_sync_slider("SFX", $VBoxContainer/ScrollContainer/OptionsList/SFXVolume/Slider)

func _sync_slider(bus_name, slider):
	var bus_idx = AudioServer.get_bus_index(bus_name)
	if bus_idx != -1:
		slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_idx)) * 100.0
	else:
		slider.editable = false
		slider.tooltip_text = "Bus " + bus_name + " not found"

func _set_volume(bus_name, value):
	var bus_idx = AudioServer.get_bus_index(bus_name)
	if bus_idx != -1:
		AudioServer.set_bus_volume_db(bus_idx, linear_to_db(value / 100.0))

func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	# Verify and sync state (in case OS denies fullscreen)
	await get_tree().process_frame
	var actual_full = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	$VBoxContainer/ScrollContainer/OptionsList/Fullscreen/CheckButton.set_pressed_no_signal(actual_full)
