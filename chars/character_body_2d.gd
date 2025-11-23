extends CharacterBody2D

@export var speed: float = 150.0

@onready var sprite_2d: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	# [ Código de Movimento aqui... ]
	var move_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if move_direction:
		velocity = move_direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# --- Rotação para Olhar para o Mouse ---
	var mouse_position: Vector2 = get_global_mouse_position()
	
	# 1. Faz o sprite olhar para o mouse (apontando o eixo X positivo para o mouse)
	sprite_2d.look_at(mouse_position)
	
	# 2. APLIQUE A CORREÇÃO NECESSÁRIA AQUI:
	# Por exemplo, se seu sprite aponta para cima no editor, ele precisa ser girado +90 graus (PI/2) para olhar corretamente.
	# Escolha o valor da correção com base na direção padrão do seu sprite:
	
	# Se o sprite estiver desenhado OLHANDO PARA CIMA:
	sprite_2d.rotation += deg_to_rad(90)
	
	# SE o sprite estiver desenhado OLHANDO PARA BAIXO:
	# sprite_2d.rotation += deg_to_rad(-90)
	
	# SE o sprite estiver desenhado OLHANDO PARA A ESQUERDA:
	# sprite_2d.rotation += deg_to_rad(180)
