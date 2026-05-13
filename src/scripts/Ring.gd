extends Area2D

var collected = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not collected and body is SonicPlayer:
		collected = true
		GameManager.rings += 1
		GameManager.boost += 5.0
		$Sprite2D.hide()
		set_deferred("monitoring", false)
		$AudioStreamPlayer.play()
		await $AudioStreamPlayer.finished
		queue_free()
