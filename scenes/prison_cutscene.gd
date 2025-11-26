extends Node2D

@onready var fade = $FadeOverlay
@onready var texture = $TextureRect
@onready var anim = $AnimationPlayer

func _ready():
	fade.modulate.a = 1
	texture.modulate.a = 1

	anim.play("fade_in")
