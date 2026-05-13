"""
this is the controller script for the basic egg pawn enemy. It is currently 
pretty basic, but I'll probably update it a bit more later
"""

extends Area2D

@export var boostParticle: PackedScene


var alive = true


var splodeVel = Vector2(0, 0)


@onready var boomSound = $BoomSound

func _ready():
	pass


func _process(_delta):
	
	if alive:
		
		position.x -= 0.1
	else:
		
		
		position += splodeVel
		rotation += 0.1
		splodeVel.y += 0.2



func _on_EggPawn_area_entered(area):
	
	
	if area.is_in_group("Player") and alive:
		
		
		if not area.isAttacking():
			area.hurt_player()
		elif area.state == -1:
			
			area.velocity1.y = -5
		if area.isAttacking():
			if boostParticle:
				var newNode = boostParticle.instantiate()
				newNode.position = position
				newNode.boostValue = 2
				get_tree().current_scene.add_child(newNode)
		
		
		alive = false
		
		
		splodeVel = area.get("velocity1") * 1.5
		splodeVel.y = min(splodeVel.y, 10)
		splodeVel.y -= 7
		
		
		boomSound.play()
