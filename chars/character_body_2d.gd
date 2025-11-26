extends CharacterBody2D

# Variáveis
var has_flashlight: bool = false
var has_key: bool = false
var can_move: bool = false

@export var speed: float = 200.0

# Referências
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var flashlight: PointLight2D = $Sprite2D/LanternHand/PointLight2D

func _ready():
	flashlight.enabled = false
	
	await get_tree().create_timer(2.0).timeout
	can_move = true

func _input(event):
	if event.is_action_pressed("ui_accept") and has_flashlight:
		flashlight.enabled = not flashlight.enabled

func activate_flashlight_capability():
	has_flashlight = true
	flashlight.enabled = true
	
func activate_doors():
	has_key = true

func _physics_process(_delta: float) -> void:
	if not can_move:
		velocity = Vector2.ZERO
		return
	
	var move_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if move_direction:
		velocity = move_direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	rotation_logic()

func rotation_logic():
	var mouse_position: Vector2 = get_global_mouse_position()
	
	sprite_2d.look_at(mouse_position)
	
	sprite_2d.rotate(deg_to_rad(90))
