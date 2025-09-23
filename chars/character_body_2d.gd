extends CharacterBody2D


const SPEED = 300.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	animated_sprite.play("default")
	velocity.x = move_toward(velocity.x, 0, SPEED)
