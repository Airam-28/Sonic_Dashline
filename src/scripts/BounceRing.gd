"""
this script is for the bouncy-type rings that fly out of you when you get hit
"""

extends Area2D



var collected = false


@onready var downCast = $DownCast

@onready var sprite = $AnimatedSprite

@onready var audio = $AudioStreamPlayer


var collectionStartTimer = 120


@export var velocity1: Vector2 = Vector2(0, 0)


func _ready():
	pass


func _process(_delta):
	
	
	if collected and sprite.animation == "Sparkle" and \
		sprite.frame >= 3:
		queue_free()

func _physics_process(_delta):
	
	
	collectionStartTimer -= 1
	
	if not collected:
		
		if downCast.is_colliding() and downCast.get_collision_point().y < position.y + 16:
			velocity1.y *= -1
			
		
		velocity1.y += 0.02
		
		
		position += velocity1
	
	
	if collectionStartTimer < -900:
		sprite.modulate = Color(1, 1, 1, 1 - (-collectionStartTimer % 30) / 30.0)
	
	
	if collectionStartTimer < -1080:
		queue_free()

func _on_Ring_area_entered(area):
	
	
	if not collected and area.is_in_group("Player") and collectionStartTimer <= 0:
		collected = true					
		sprite.play("Sparkle")			
		audio.play()					
		GameManager.rings += 1			
