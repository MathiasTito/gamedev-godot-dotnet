extends Node2D

@onready var fade = $FadeOverlay
@onready var anim = $AnimationPlayer

func _ready():
	fade.modulate.a = 1.0
	anim.play("fade_in")
	await get_tree().create_timer(1).timeout
