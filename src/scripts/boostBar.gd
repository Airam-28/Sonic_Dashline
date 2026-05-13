extends Control

func _ready():
	GameManager.boost_changed.connect(_on_boost_changed)

func _on_boost_changed(value):
	$ProgressBar.value = value
