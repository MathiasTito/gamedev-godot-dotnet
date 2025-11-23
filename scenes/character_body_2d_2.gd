extends CharacterBody2D

@export var speed: float = 150.0

@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	var move_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if move_direction:
		velocity = move_direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()
