extends PanelContainer

func _ready():
	GameManager.rings_changed.connect(_on_rings_changed)

func _on_rings_changed(count):
	$HBox/Count.text = str(count).pad_zeros(3)
