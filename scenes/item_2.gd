extends Area2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	anim.play("default")

func _on_body_entered(body):
	if body.has_method("activate_doors"):	
		body.activate_doors()
		queue_free()
