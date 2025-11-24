extends CharacterBody2D

@export var speed: float = 150.0

@onready var flashlight = $Sprite2D/LanternHand/PointLight2D_lantern 
@onready var sprite_2d: Sprite2D = $Sprite2D

func _input(event):
	if event.is_action_pressed("ui_accept"): 
		flashlight.enabled = !flashlight.enabled

func _physics_process(delta: float) -> void:
	# --- Movimento ---
	
	var move_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if move_direction:
		velocity = move_direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	# --- Rotação Geral ---
	rotation_logic()

func rotation_logic():
	var mouse_position: Vector2 = get_global_mouse_position()
	
	# Giramos APENAS o Sprite. 
	# Como a Lanterna é filha dele, ela gira junto automaticamente.
	sprite_2d.look_at(mouse_position)
	
	# Correção porque seu desenho (e provavelmente a luz) apontam para CIMA
	sprite_2d.rotation += deg_to_rad(90)
