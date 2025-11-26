extends Area2D

func _on_body_entered(body):
	if body.has_method("activate_flashlight_capability"):
		body.activate_flashlight_capability()
		
		# (Opcional) Tocar um som aqui antes de deletar
		
		queue_free()
