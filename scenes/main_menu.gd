extends Node

@onready var fade = $FadeOverlay
@onready var label = $Label
@onready var anim = $AnimationPlayer

func _ready():
	fade.modulate.a = 0.0
	label.modulate.a = 0.0

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start_game_transition()

func start_game_transition():
	anim.play("fade_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://scenes/main.tscn")
