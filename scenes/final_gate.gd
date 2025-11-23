extends StaticBody2D

# Arraste o nó "BarreiraCollision" para este campo no Inspetor!
@export var barreira: CollisionShape2D

# Arraste o nó "Area2D" para este campo no Inspetor
@export var interaction_area: Area2D

var is_open = false
var player_is_near = false

func _ready():
	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)
	update_door_state()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_is_near = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_is_near = false

func _process(delta):
	if player_is_near and Input.is_action_just_pressed("interact"):
		is_open = not is_open
		update_door_state()

func update_door_state():
	if is_open:
		# AQUI ESTÁ A MUDANÇA: Usamos a variável 'barreira'
		barreira.disabled = true
		print("Porta aberta, colisão DESATIVADA")
	else:
		# E AQUI
		barreira.disabled = false
		print("Porta fechada, colisão ATIVADA")
