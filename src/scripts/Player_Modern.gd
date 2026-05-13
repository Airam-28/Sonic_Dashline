extends CharacterBody2D
class_name SonicPlayer

@export var speed := 600.0
@export var boost_speed := 1200.0
@export var acceleration := 1500.0
@export var friction := 2000.0
@export var jump_velocity := -800.0
@export var gravity := 2000.0

var is_boosting := false
var was_boosting := false
@onready var sprite = $PlayerSprites

func _ready():
	sprite.flip_h = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	is_boosting = Input.is_action_pressed("boost") and GameManager.boost > 0
	
	if is_boosting and not was_boosting:
		$BoostAudio.play()
	was_boosting = is_boosting
	
	if is_boosting:
		GameManager.boost -= 20.0 * delta
	else:
		GameManager.boost = move_toward(GameManager.boost, 100.0, 5.0 * delta)

	var current_speed = boost_speed if is_boosting else speed
	var direction := Input.get_axis("move left", "move right")
	
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * current_speed, acceleration * delta)
		sprite.flip_h = direction > 0
		if is_on_floor():
			if is_boosting:
				sprite.play("Boost")
			else:
				sprite.play("Run4")
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		if is_on_floor():
			if Input.is_action_pressed("ui_down"):
				sprite.play("Crouch")
			else:
				sprite.play("idle")

	if not is_on_floor():
		sprite.play("Roll")

	move_and_slide()
