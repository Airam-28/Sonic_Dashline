extends Area2D

@export var bounce_force: float = -1200.0

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is SonicPlayer:
		body.velocity.y = bounce_force
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.play("default")
		$AudioStreamPlayer.play()
