extends Node2D

@onready var door_collision = $door/door
@onready var color = $ColorRect

var is_open = false

func open_door():
	is_open = true
	color.visible = false
	door_collision.set_deferred("disabled", true)

func _on_main_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print(body.has_key)
	if body.has_method("activate_doors") and body.has_key == true:
		call_deferred("open_door")
